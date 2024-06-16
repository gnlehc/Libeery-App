import 'package:libeery/outputs/baseoutput_model.dart';

class MsBook {
  final int bookID;
  final String isbn;
  final String title;
  final String author;
  final String publisher;
  final String edition;
  final int year;
  final String abstract;
  final int stock;
  final String photo;
  final String stsrc;

  MsBook({
    required this.bookID,
    required this.isbn,
    required this.title,
    required this.author,
    required this.publisher,
    required this.edition,
    required this.year,
    required this.abstract,
    required this.stock,
    required this.photo,
    required this.stsrc,
  });

  factory MsBook.fromJson(Map<String, dynamic> json) {
    return MsBook(
      bookID: json['BookID'] ?? 0,
      isbn: json['ISBN'] ?? "",
      title: json['Title'] ?? "",
      author: json['Author'] ?? "",
      publisher: json['Publisher'] ?? "",
      edition: json['Edition'] ?? "",
      year: json['Year'] ?? 0,
      abstract: json['Abstract'],
      stock: json['Stock'] ?? 0,
      photo: json['Photo'],
      stsrc: json['Stsrc'] ?? "",
    );
  }
}

class GetAllMsBookData {
  List<MsBook>? data;
  BaseOutput? baseOutput;
  GetAllMsBookData({
    this.data,
    this.baseOutput,
  });

  factory GetAllMsBookData.fromJson(Map<String, dynamic> json) {
    return GetAllMsBookData(
      data: List<MsBook>.from(json["Data"].map((x) => MsBook.fromJson(x))),
      baseOutput: BaseOutput.fromJson(json['BaseOutput']),
    );
  }
}

class ScanOnGoingRequestDTO {
  final String userID;
  final String bookingID;

  ScanOnGoingRequestDTO({required this.userID, required this.bookingID});

  factory ScanOnGoingRequestDTO.toJson(Map<String, dynamic> json) {
    return ScanOnGoingRequestDTO(
        userID: json['UserID'], bookingID: json['BookingID']);
  }
}

class ScanOnGoingResponseDTO {
  final String userID;
  final String bookingID;

  ScanOnGoingResponseDTO({
    required this.userID,
    required this.bookingID,
  });

  Map<String, dynamic> fromJson() {
    return {
      'UserID': userID,
      'BookingID': bookingID,
    };
  }
}
