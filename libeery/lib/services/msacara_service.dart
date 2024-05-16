import 'package:dio/dio.dart';
import 'package:libeery/models/msacara_model.dart';

class AcaraService {
  static const baseUrl =
      'https://libeery-api-development.up.railway.app/api/private/acara';

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
      throw Exception(e.toString());
    }
  }
}
