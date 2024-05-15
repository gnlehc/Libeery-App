import 'package:dio/dio.dart';
import 'package:libeery/models/msacara_model.dart';

class MsAcaraServices {
  final dio = Dio();
  static Future<MsAcara> fetchAcaraDetails () async {
    const url ='https://libeery-api-development.up.railway.app/api/private/acara-detail?id=1';

   try {
      final dio = Dio();
      final response = await dio.get(url);

      if (response.statusCode == 200) {
        Map<String, dynamic> data = response.data;
        MsAcara acaraDetail = MsAcara.fromJson(data['Data']);
        return acaraDetail;

        
      } else {
        throw Exception('Failed to load event: ${response.statusCode}');
      }
    } catch (e) {
      throw Exception('Failed to load event: $e');
    }
  }
}