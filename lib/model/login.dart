class LoginModel {
  int? id;
  String? nama;
  String? email;
  String? token;

  LoginModel({
    this.id,
    this.nama,
    this.email,
    this.token,
  });

  factory LoginModel.fromJson(Map<String, dynamic> json) {
    return LoginModel(
      id: int.tryParse(json["id"].toString()),
      nama: json["nama"],
      email: json["email"],
      token: json["token"],
    );
  }
}
