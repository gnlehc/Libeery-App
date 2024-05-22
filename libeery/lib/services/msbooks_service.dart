import 'package:libeery/models/msbooks_model.dart';
import 'package:dio/dio.dart';

class BookService{
  static const baseUrl = 'https://libeery-api-development.up.railway.app/api/private/get-all-books';

  Future<GetAllMsBookData> getBook() async{
    try{
      final dio = Dio();
      final response = await dio.get(baseUrl);
      GetAllMsBookData result = GetAllMsBookData.fromJson(response.data);
      return result;
    }catch(e){
      print(e.toString());
      throw Exception(e.toString());
    }
  }

    static Future<MsBook> fetchBookDetails(int bookID) async {
     final url =
        'https://libeery-api-development.up.railway.app/api/private/book-detail?id=$bookID';

    try {
      final dio = Dio();
      final response = await dio.get(url);

      if (response.statusCode == 200) {
        Map<String, dynamic> data = response.data;
        MsBook bookDetail = MsBook.fromJson(data['Data']);
        return bookDetail;
      } else {
        throw Exception('Failed to load event: ${response.statusCode}');
      }
    } catch (e) {
      throw Exception('Failed to load event: $e');
    }
  }
}