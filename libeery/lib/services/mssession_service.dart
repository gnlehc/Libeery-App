import 'dart:convert';

import 'package:dio/dio.dart';
import 'package:libeery/models/mssession_model.dart';

class MsSessionService {
  static Future<List<MsSession>> getSessionfromAPI() async {
    const url =
        'https://libeery-api-development.up.railway.app/api/private/sessions';

    try {
      final dio = Dio();
      final response = await dio.get(url);

      if (response.statusCode == 200) {
        final List<dynamic> responseData = response.data['Data'];
        List<MsSession> sessions = [];

        for (var sessionData in responseData) {
          sessions.add(MsSession.fromJson(sessionData));
        }

        return sessions;
      } else {
        throw Exception('Failed to load sessions: ${response.statusCode}');
      }
    } catch (e) {
      throw Exception('Failed to load sessions: $e');
    }
  }

  static Future<String?> postDatatoAPI(SessionRequestDTO postSession) async {
    const url =
        'https://libeery-api-development.up.railway.app/api/private/bookSession';
    try {
      final dio = Dio();
      dio.options.validateStatus = (status) {
        return true;
      };

      Response response = await dio.post(
        url,
        data: json.encode(postSession.toJson()),
        options: Options(headers: {
          'Content-Type': 'application/json',
        }),
      );

      if (response.statusCode == 200) {
        return null;
      } else {
        return response.data['Message'] ?? 'Unknown error occured';
      }
    } catch (error) {
      return 'Unexpected error occured: $error';
    }
  }
}
