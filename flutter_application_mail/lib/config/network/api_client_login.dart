import 'package:dio/dio.dart';

class ApiClient {
  // 🔥 Singleton Instance
  static final ApiClient instance = ApiClient._internal();

  // Base URL utama (user)
  static const String baseUrl =
      'https://wsmailbe-7daa66974ddc.herokuapp.com/api/user';

  late final Dio _dio;

  // Constructor privat untuk Singleton
  ApiClient._internal() {
    _dio = Dio(
      BaseOptions(
        baseUrl: baseUrl,
        connectTimeout: const Duration(seconds: 40),
        receiveTimeout: const Duration(seconds: 40),
        sendTimeout: const Duration(seconds: 40),
        contentType: 'application/json',
        headers: {
          'Accept': 'application/json',
        },
      ),
    );

    // Logging
    _dio.interceptors.add(
      LogInterceptor(
        request: true,
        requestBody: true,
        responseBody: true,
        error: true,
        logPrint: (obj) => print("📡 API LOG: $obj"),
      ),
    );

    // Auto Retry jika Timeout
    _dio.interceptors.add(
      InterceptorsWrapper(
        onError: (DioException e, handler) async {
          if (e.type == DioExceptionType.connectionTimeout ||
              e.type == DioExceptionType.receiveTimeout) {
            print("⚠️ Timeout, mencoba ulang...");

            try {
              final retryResponse = await _dio.request(
                e.requestOptions.path,
                data: e.requestOptions.data,
                queryParameters: e.requestOptions.queryParameters,
                options: Options(method: e.requestOptions.method),
              );

              return handler.resolve(retryResponse);
            } catch (_) {
              return handler.next(e);
            }
          }
          return handler.next(e);
        },
      ),
    );
  }

  // Getter dio utama
  Dio get dio => _dio;

  // 🔥 Public API untuk Login
  Dio get public {
    return Dio(
      BaseOptions(
        baseUrl: "https://wsmailbe-7daa66974ddc.herokuapp.com/api/public",
        connectTimeout: const Duration(seconds: 40),
        receiveTimeout: const Duration(seconds: 40),
        contentType: 'application/json',
      ),
    );
  }
}
