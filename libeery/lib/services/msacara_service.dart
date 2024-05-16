import 'package:dio/dio.dart';
import 'package:libeery/models/msacara_model.dart';


class MsAcaraServices {
  final dio = Dio();
  static Future<MsAcara> fetchAcaraDetails () async {
    const url ='https://libeery-api-development.up.railway.app/api/private/acara-detail?id=1';

  static Future<List<MsAcara>> getAcaraForHomePage() async {
    try {

      final dio = Dio();
      const url = '$baseUrl?page=1&take=4';
      Response response = await dio.get(url);

      if (response.statusCode == 200) {
        List<dynamic> jsonData = response.data['Data'];
        List<MsAcara> tempAcara =
            jsonData.map((json) => MsAcara.fromJson(json)).toList();
        return tempAcara;
      } else {
        throw Exception('Failed to load acara data: ${response.statusCode}');
      }
    } catch (e) {
      throw Exception('Failed to load event: $e');
    }
  }
}
