class MsAcara {
  final int acaraID;
  final String acaraName;
  final String acaraStartTime;
  final String acaraEndTime;
  final String acaraDate;
  final String acaraLocation;
  final String acaraDetails;
  final String speakerName;
  final String registerLink;
  final String acaraImage;

  MsAcara({
    required this.acaraID,
    required this.acaraName,
    required this.acaraStartTime,
    required this.acaraEndTime,
    required this.acaraDate,
    required this.acaraLocation,
    required this.acaraDetails,
    required this.speakerName,
    required this.registerLink,
    required this.acaraImage,
  });

  factory MsAcara.fromJson(Map<String, dynamic> json) {
    return MsAcara(
      acaraID: json['AcaraID'],
      acaraName: json['AcaraName'],
      acaraStartTime: json['AcaraStartTime'],
      acaraEndTime: json['AcaraEndTime'],
      acaraDate: json['AcaraDate'],
      acaraLocation: json['AcaraLocation'],
      acaraDetails: json['AcaraDetails'],
      speakerName: json['SpeakerName'],
      registerLink: json['RegisterLink'],
      acaraImage: json['AcaraImage'],
    );
  }
}
