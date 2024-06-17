import 'package:libeery/models/msloker_model.dart';
import 'package:dio/dio.dart';
import 'package:logger/logger.dart';

class LokerService {
  final Logger logger = Logger(
    printer: PrettyPrinter(),
    level: Level.debug,
  );
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

  Future<GetAllMsLokerData> getLokerById(List<int> ids) async {
    const String baseUrl =
        'https://libeery-api-development.up.railway.app/api/private/LokerByMultipleSessionID?session_ids=';
    final String queryString = ids.join(',');
    final String url = '$baseUrl$queryString';

    try {
      final dio = Dio();
      final response = await dio.get(url);
      logger.d(response.data.toString());
      GetAllMsLokerData result = GetAllMsLokerData.fromJson(response.data);
      logger.d(result.data);
      return result;
    } catch (e) {
      print(e.toString());
      throw Exception(e.toString());
    }
  }
}
