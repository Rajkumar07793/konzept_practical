import 'dart:convert';
import "package:http/http.dart" as http;
import 'package:konzept_practical/globals/constants.dart';

Future<OtpResponse> verifyOtp(String mobile, String otp) async {
  var response = await http.post(Uri.parse('${baseUrl}verify'), body: {
    "mobile": mobile,
    "otp": otp,
  });
  if (response.statusCode == 200) {
    var data = json.decode(response.body);
    print(data);
    if (data['status'] == true) {
      return OtpResponse.fromMap(data);
    } else {
      throw Exception(response.body);
    }
  } else {
    throw Exception(response.body);
  }
}

class OtpResponse {
  OtpResponse({
    required this.statusCode,
    required this.message,
    required this.data,
    required this.token,
    required this.status,
  });

  final int statusCode;
  final String message;
  final Data? data;
  final String? token;
  final bool status;

  factory OtpResponse.fromMap(Map<String, dynamic> json) => OtpResponse(
        statusCode: json["statusCode"],
        message: json["message"],
        data: json["data"] == null ? null : Data.fromMap(json["data"]),
        token: json["token"],
        status: json["status"],
      );

  Map<String, dynamic> toMap() => {
        "statusCode": statusCode,
        "message": message,
        "data": data!.toMap(),
        "token": token,
        "status": status,
      };
}

class Data {
  Data({
    required this.id,
    required this.name,
    required this.email,
    required this.mobile,
  });

  final int id;
  final dynamic name;
  final dynamic email;
  final String mobile;

  factory Data.fromMap(Map<String, dynamic> json) => Data(
        id: json["id"],
        name: json["name"],
        email: json["email"],
        mobile: json["mobile"],
      );

  Map<String, dynamic> toMap() => {
        "id": id,
        "name": name,
        "email": email,
        "mobile": mobile,
      };
}
