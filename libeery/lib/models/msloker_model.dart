// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:libeery/outputs/baseoutput_model.dart';

class MsLoker {
  final int lockerID;
  final int rowNumber;
  final int columnNumber;
  final String availability;
  final String stsrc;

  MsLoker({
    required this.lockerID,
    required this.rowNumber,
    required this.columnNumber,
    required this.availability,
    required this.stsrc,
  });

  factory MsLoker.fromJson(Map<String, dynamic> json) {
    return MsLoker(
      lockerID: json['LokerID'] ?? 0,
      rowNumber: json['RowNumber'] ?? 0,
      columnNumber: json['ColumnNumber'] ?? 0,
      availability: json['Availability'] ?? "",
      stsrc: json['Stsrc'] ?? "",
    );
  }
}

class GetAllMsLokerData {
  List<MsLoker>? data;
  BaseOutput? baseOutput;
  GetAllMsLokerData({
    this.data,
    this.baseOutput,
  });

  
  factory GetAllMsLokerData.fromJson(Map<String, dynamic> json) {
    return GetAllMsLokerData(
      data: List<MsLoker>.from(json["data"].map((x) => MsLoker.fromJson(x))),
        baseOutput: BaseOutput(
            message: json["baseOutput"]['message'],
            statusCode: json["baseOutput"]['statusCode']),
    );
  }
}
