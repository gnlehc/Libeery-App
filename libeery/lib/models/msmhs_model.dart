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
      userId: json['userid'],
      username: json['username'],
      message: json['message'],
      statusCode: json['statuscode'],
    );
  }
}
