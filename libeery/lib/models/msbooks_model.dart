import 'package:libeery/outputs/baseoutput_model.dart';

class MsBook {
  final int bookID;
  final String isbn;
  final String title;
  final String author;
  final String publisher;
  final String edition;
  final int year;
  final int stock;
  final String stsrc;

  MsBook({
    required this.bookID,
    required this.isbn,
    required this.title,
    required this.author,
    required this.publisher,
    required this.edition,
    required this.year,
    required this.stock,
    required this.stsrc,
  });

  factory MsBook.fromJson(Map<String, dynamic> json) {
    return MsBook(
      bookID: json['LokerID'] ?? 0,
      isbn: json['RowNumber'] ?? "",
      title: json['ColumnNumber'] ?? "",
      author: json['Availability'] ?? "",
      publisher: json['Publisher'] ?? "",
      edition: json['Edition'] ?? "",
      year: json['Year'] ?? 0,
      stock: json['Stock'] ?? 0,
      stsrc: json['Stsrc'] ?? "",
    );
  }
}

// class GetAllMsBookData {
//   List<MsBook>? data;
//   BaseOutput? baseOutput;
//   GetAllMsBookData({
//     this.data,
//     this.baseOutput,
//   });

  
//   factory GetAllMsBookData.fromJson(Map<String, dynamic> json) {
//     return GetAllMsBookData(
//       data: List<MsBook>.from(
//           json["Data"].map((x) => MsBook.fromJson(x))),
//       baseOutput: BaseOutput.fromJson(json['BaseOutput']),
//     );
//   }
// }