// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:libeery/outputs/baseoutput_model.dart';

class MsAcara {
  final int acaraID;
  final String acaraName;
  final DateTime acaraStartTime;
  final DateTime acaraEndTime;
  final DateTime acaraDate;
  final String acaraLocation;
  final String acaraDetails;
  final String speakerName;
  final String registerLink;
  final String acaraImage;
  final String stsrc;

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
    required this.stsrc,
  });

  factory MsAcara.fromJson(Map<String, dynamic> json) {
    return MsAcara(
      acaraID: json['AcaraID'],
      acaraName: json['AcaraName'],
      acaraStartTime: DateTime.parse(json['AcaraStartTime']),
      acaraEndTime: DateTime.parse(json['AcaraEndTime']),
      acaraDate: DateTime.parse(json['AcaraDate']),
      acaraLocation: json['AcaraLocation'],
      acaraDetails: json['AcaraDetails'],
      speakerName: json['SpeakerName'],
      registerLink: json['RegisterLink'],
      acaraImage: json['AcaraImage'],
      stsrc: json['Stsrc'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'AcaraID': acaraID,
      'AcaraName': acaraName,
      'AcaraStartTime': acaraStartTime,
      'AcaraEndTime': acaraEndTime,
      'AcaraDate': acaraDate,
      'AcaraLocation': acaraLocation,
      'AcaraDetails': acaraDetails,
      'SpeakerName': speakerName,
      'RegisterLink': registerLink,
      'AcaraImage': acaraImage,
      'Stsrc': stsrc,
    };
  }
}

class GetListAcara {
  List<MsAcara>? data;
  BaseOutput? baseOutput;
  GetListAcara({
    this.data,
    this.baseOutput,
  });
  factory GetListAcara.fromJson(Map<String, dynamic> json) {
    return GetListAcara(
        data: List<MsAcara>.from(json['Data'].map((x) => MsAcara.fromJson(x))),
        baseOutput: BaseOutput.fromJson(json['BaseOutput']));
  }
}
