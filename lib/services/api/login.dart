import 'dart:convert';
import "package:http/http.dart" as http;
import 'package:konzept_practical/globals/constants.dart';
import 'package:konzept_practical/globals/functions/toast.dart';

Future<LoginResponse> login(String mobile) async {
  var response = await http.post(Uri.parse('${baseUrl}login'), body: {
    "mobile": mobile,
  });
  if (response.statusCode == 200) {
    var data = json.decode(response.body);
    print(data);
    if (data['status'] == true) {
      return LoginResponse.fromMap(data);
    } else {
      showToast(data['message']);
      throw Exception(response.body);
    }
  } else {
    throw Exception(response.body);
  }
}

class LoginResponse {
  LoginResponse({
    required this.statusCode,
    required this.status,
    required this.message,
  });

  final int statusCode;
  final bool status;
  final String message;

  factory LoginResponse.fromMap(Map<String, dynamic> json) => LoginResponse(
        statusCode: json["statusCode"],
        status: json["status"],
        message: json["message"],
      );

  Map<String, dynamic> toMap() => {
        "statusCode": statusCode,
        "status": status,
        "message": message,
      };
}
