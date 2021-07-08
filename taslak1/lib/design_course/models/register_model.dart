import 'dart:convert';

RegisterModel registerModelFromJson(String str) => RegisterModel.fromJson(json.decode(str));

String registerModelToJson(RegisterModel data) => json.encode(data.toJson());

class RegisterModel {
  RegisterModel({
    this.status,
  });

  bool status;

  factory RegisterModel.fromJson(Map<String, dynamic> json) => RegisterModel(
        status: json["status"],
      );

  Map<String, dynamic> toJson() => {
        "status": status,
      };
}
