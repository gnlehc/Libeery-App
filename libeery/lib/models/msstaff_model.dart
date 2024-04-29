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

  Map<String, dynamic> loginStaffReponseDTO(Map<String, dynamic> json) {
    return {
      'statusCode': json['statuscode'],
      'message': json['message'],
      'userId': json['userid'],
    };
  }
}
