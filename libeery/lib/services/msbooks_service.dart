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
}