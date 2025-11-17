import 'package:dio/dio.dart';

class ApiClient {
  static const String baseUrl =
      'https://ats-714220023-serlipariela-38bba14820aa.herokuapp.com/';

  late final Dio _dio;

  ApiClient() {
    _dio = Dio(
      BaseOptions(
        baseUrl: baseUrl,
        connectTimeout: const Duration(seconds: 40), // ⏱️ timeout lebih lama
        receiveTimeout: const Duration(seconds: 40),
        sendTimeout: const Duration(seconds: 40),
        headers: {
          'Content-Type': 'application/json',
          'Accept': 'application/json',
        },
      ),
    );

    // 🔹 Tambahkan Logging
    _dio.interceptors.add(LogInterceptor(
      request: true,
      requestBody: true,
      responseBody: true,
      responseHeader: false,
      error: true,
      logPrint: (obj) => print("📡 API LOG: $obj"),
    ));

    // 🔹 Tambahkan Auto Retry (kalau timeout atau koneksi gagal)
    _dio.interceptors.add(
      InterceptorsWrapper(
        onError: (DioException e, ErrorInterceptorHandler handler) async {
          // kalau timeout, coba sekali lagi
          if (e.type == DioExceptionType.connectionTimeout ||
              e.type == DioExceptionType.receiveTimeout) {
            print("⚠️ Timeout, mencoba ulang...");
            try {
              final cloneReq = await _dio.request(
                e.requestOptions.path,
                data: e.requestOptions.data,
                queryParameters: e.requestOptions.queryParameters,
                options: Options(
                  method: e.requestOptions.method,
                ),
              );
              return handler.resolve(cloneReq);
            } catch (retryError) {
              return handler.next(e);
            }
          }
          return handler.next(e);
        },
      ),
    );
  }

  Dio get dio => _dio;
}
