import 'package:dio/dio.dart';
import 'package:libeery/models/msuser_model.dart';

class MsUserService {
  final dio = Dio();
  Future<AllUserBookedSession> usersBookedSessions(String? userID) async {
    try {
      final result = await dio.get(
          'https://libeery-api-development.up.railway.app/api/private/user-bookings',
          queryParameters: {'userID': userID});
      AllUserBookedSession res = AllUserBookedSession.fromJson(result.data);

      return res;
    } catch (e) {
      rethrow;
    }
  }
}
