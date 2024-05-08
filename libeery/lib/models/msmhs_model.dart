import 'dart:convert';

// ignore_for_file: public_member_api_docs, sort_constructors_first
class MsMhs {
  String nim;
  String mhsPassword;

  MsMhs({required this.nim, required this.mhsPassword});

  Map<String, dynamic> toJson() {
    return {
      'nim': nim,
      'password': mhsPassword,
    };
  }

  factory MsMhs.fromJson(Map<String, dynamic> json) {
    return MsMhs(
      nim: json['nim'],
      mhsPassword: json['mhs_password'],
    );
  }
  Map<String, dynamic> loginMhsReponseDTO(Map<String, dynamic> json) {
    return {
      'statusCode': json['statuscode'],
      'message': json['message'],
      'userId': json['userid'],
      'username': json["username"]
    };
  }
}

class LoginMhsResponseDTO {
  int? statusCode;
  String? message;
  String? userId;
  String? username;
  LoginMhsResponseDTO({
    this.statusCode,
    this.message,
    this.userId,
    this.username,
  });

  factory LoginMhsResponseDTO.fromJson(Map<String, dynamic> json) {
    return LoginMhsResponseDTO(
        message: json['message'],
        statusCode: json['statuscode'],
        userId: json['userid'],
        username: json['username']);
  }

  @override
  String toString() {
    return 'LoginMhsResponseDTO(statusCode: $statusCode, message: $message, userId: $userId, username: $username)';
  }

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'statusCode': statusCode,
      'message': message,
      'userId': userId,
      'username': username,
    };
  }

  factory LoginMhsResponseDTO.fromMap(Map<String, dynamic> map) {
    return LoginMhsResponseDTO(
      statusCode: map['statusCode'] != null ? map['statusCode'] as int : null,
      message: map['message'] != null ? map['message'] as String : null,
      userId: map['userId'] != null ? map['userId'] as String : null,
      username: map['username'] != null ? map['username'] as String : null,
    );
  }

  String toJson() => json.encode(toMap());
}
