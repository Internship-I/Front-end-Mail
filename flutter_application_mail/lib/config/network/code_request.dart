class CodeRequest {
  static String handleError(dynamic error) {
    if (error is Exception) {
      return "Koneksi gagal, periksa internet Anda";
    }
    return "Terjadi kesalahan tak terduga";
  }
}
