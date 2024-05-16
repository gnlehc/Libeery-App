import 'package:libeery/models/msloker_model.dart';
import 'package:dio/dio.dart';

class LokerService {
  static const baseUrl =
      'https://libeery-api-development.up.railway.app/api/private/lokers';

  Future<GetAllMsLokerData> getLoker() async {
    try {
      final dio = Dio();
      final response = await dio.get(baseUrl);
      GetAllMsLokerData result = GetAllMsLokerData.fromJson(response.data);
      return result;
    } catch (e) {
      print(e.toString());
      throw Exception(e.toString());
    }
  }
}
