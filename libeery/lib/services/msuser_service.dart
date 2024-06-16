import 'package:dio/dio.dart';
import 'package:libeery/models/msuser_model.dart';

class MsUserService {
  static final dio = Dio();
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

  static Future<MsUser> getUserProfile(
      RequestUserBookedSession requestUser) async {
    final userId = requestUser.userID;

    if (userId == null) {
      throw Exception('User ID is null');
    }

    try {
      final response = await dio.get(
        'https://libeery-api-development.up.railway.app/api/private/user-profile',
        queryParameters: {'userid': userId},
      );

      if (response.statusCode == 200) {
        return MsUser.fromJson(response.data);
      } else {
        throw Exception('Failed to load user profile');
      }
    } catch (e) {
      throw Exception('Failed to connect to server');
    }
  }
}
