import 'dart:convert';

LoginModel loginModelFromJson(String str) => LoginModel.fromJson(json.decode(str));

String loginModelToJson(LoginModel data) => json.encode(data.toJson());

class LoginModel {
  LoginModel({
    this.status,
  });

  bool status;

  factory LoginModel.fromJson(Map<String, dynamic> json) => LoginModel(
        status: json["status"],
      );

  Map<String, dynamic> toJson() => {
        "status": status,
      };
}
