import 'package:libeery/models/loker.dart';
import 'package:dio/dio.dart';

class LokerService{
  static const baseUrl = 'https://libeery-api-development.up.railway.app/api/private/lokers';

  static Future<List<dynamic>> getLoker() async{
    try{
      final dio = Dio();
      Response response = await dio.get(baseUrl);

      if(response.statusCode == 200){
        List<dynamic> jsonData = response.data['Data'];
        List<MsLoker> tempLokerUser = jsonData.map((json) => MsLoker.fromJson(json)).toList();
        return tempLokerUser;
      }else{
        throw Exception('Failed to load loker data: ${response.statusCode}');
      }
    }catch(e){
      print(e.toString());
      throw Exception(e.toString());
    }
  }
}