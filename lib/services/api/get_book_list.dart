import 'dart:convert';
import "package:http/http.dart" as http;
import 'package:konzept_practical/globals/constants.dart';

Future<BookListResponse> getBookList(DateTime date) async {
  var response =
      await http.post(Uri.parse('${baseUrl}book/getBookList'), body: {
    "month": "${date.month}",
    "year": "${date.year}",
  });
  if (response.statusCode == 200) {
    var data = json.decode(response.body);
    print(data);
    if (data['status'] == true) {
      return BookListResponse.fromMap(data);
    } else {
      throw Exception(response.body);
    }
  } else {
    throw Exception(response.body);
  }
}

class BookListResponse {
  BookListResponse({
    required this.status,
    required this.dateString,
    required this.date,
  });

  final bool status;
  final String dateString;
  final List<Date> date;

  factory BookListResponse.fromMap(Map<String, dynamic> json) =>
      BookListResponse(
        status: json["status"],
        dateString: json["date_string"],
        date: List<Date>.from(json["date"].map((x) => Date.fromMap(x))),
      );

  Map<String, dynamic> toMap() => {
        "status": status,
        "date_string": dateString,
        "date": List<dynamic>.from(date.map((x) => x.toMap())),
      };
}

class Date {
  Date({
    required this.date,
  });

  final DateTime date;

  factory Date.fromMap(Map<String, dynamic> json) => Date(
        date: DateTime.parse(json["date"]),
      );

  Map<String, dynamic> toMap() => {
        "date":
            "${date.year.toString().padLeft(4, '0')}-${date.month.toString().padLeft(2, '0')}-${date.day.toString().padLeft(2, '0')}",
      };
}
