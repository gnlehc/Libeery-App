import 'dart:convert';

class MsStaff {
  String nis;
  String staffPassword;

  MsStaff({required this.nis, required this.staffPassword});

  Map<String, dynamic> toJson() {
    return {
      'NIS': nis,
      'Password': staffPassword,
    };
  }

  factory MsStaff.fromJson(Map<String, dynamic> json) {
    return MsStaff(
      nis: json['nis'],
      staffPassword: json['staff_password'],
    );
  }

  
}

class LoginStaffResponseDTO{
  int? statusCode;
  String? message;
  String? userId;
  String? username;
  LoginStaffResponseDTO({
    this.statusCode,
    this.message,
    this.userId,
    this.username,
  });

  factory LoginStaffResponseDTO.fromJson(Map<String, dynamic> json) {
    return LoginStaffResponseDTO(
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

  factory LoginStaffResponseDTO.fromMap(Map<String, dynamic> map) {
    return LoginStaffResponseDTO(
      statusCode: map['statusCode'] != null ? map['statusCode'] as int : null,
      message: map['message'] != null ? map['message'] as String : null,
      userId: map['userId'] != null ? map['userId'] as String : null,
      username: map['username'] != null ? map['username'] as String : null,
    );
  }

  String toJson() => json.encode(toMap());
}