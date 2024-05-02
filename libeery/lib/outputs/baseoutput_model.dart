// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:convert';

class BaseOutput {
  int statusCode;
  String message;

  BaseOutput({required this.statusCode, required this.message});

  factory BaseOutput.fromJson(Map<String, dynamic> json) {
    return BaseOutput(
      statusCode: json['StatusCode'],
      message: json['Message'],
    );
  }

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'statusCode': statusCode,
      'message': message,
    };
  }

  factory BaseOutput.fromMap(Map<String, dynamic> map) {
    return BaseOutput(
      statusCode: map['statusCode'] as int,
      message: map['message'] as String,
    );
  }

  String toJson() => json.encode(toMap());
}
