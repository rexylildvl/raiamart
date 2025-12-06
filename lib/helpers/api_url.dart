class ApiUrl {
  static const String baseUrl = "http://192.168.100.64:8080";

  static String login = "$baseUrl/login";
  static String registrasi = "$baseUrl/registrasi";

  static String inventaris = "$baseUrl/inventaris";
  static String inventarisById(int id) => "$baseUrl/inventaris/$id";
}
