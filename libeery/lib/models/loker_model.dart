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
      lockerID: json['LockerID'],
      rowNumber: json['RowNumber'],
      columnNumber: json['ColumnNumber'],
      availability: json['Availability'],
      stsrc: json['Stsrc'],
    );
  }
}