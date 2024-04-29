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
