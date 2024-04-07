import 'package:dio/dio.dart';
import 'package:libeery/models/loker_model.dart';

class Repository{
  final _baseUrl = 'https://libeery-api-development.up.railway.app/api/private/lokers';
  Dio dio = Dio();

  Future getLoker() async{
    try{
      final response = await dio.get(_baseUrl);

      if(response.statusCode == 200){
        print(response.data);
        List<dynamic> jsonData = response.data;
        List<MsLoker> tempLokerUser = jsonData.map((json) => MsLoker.fromJson(json)).toList();
        return tempLokerUser;
      }
    }catch(e){
      print(e.toString());
    }
  }
}