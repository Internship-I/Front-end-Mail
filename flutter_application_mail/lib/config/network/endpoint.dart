class Endpoint {
  // 🔹 BASE URL PUBLIC (untuk login, register, dll)
  static const String baseUrlPublic =
      "https://wsmailbe-7daa66974ddc.herokuapp.com/api/public";

  // 🔹 LOGIN
  static const String login = "$baseUrlPublic/login";

  // 🔹 BASE URL USER (semua endpoint setelah user)
  static const String baseUrlUser =
      "https://wsmailbe-7daa66974ddc.herokuapp.com/api/user";

  // 🔹 USER & KURIR
  static const String getAllUsers = "$baseUrlUser/getallusers";

  // 🔹 TRANSAKSI
  static const String insertTransaction = "$baseUrlUser/inserttrans";
  static const String getAllTransaction = "$baseUrlUser/getalltransactions";
  static const String getAllSender = "$baseUrlUser/getallsender";
}
