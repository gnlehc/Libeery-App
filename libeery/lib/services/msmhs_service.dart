// ignore: depend_on_referenced_packages
import 'package:dio/dio.dart';
import 'package:libeery/models/msmhs_model.dart';

class MsMhsService {
  static Future<List<dynamic>> loginMhs(
      String nomorInduk, String password) async {
    try {
      final dio = Dio();
      dio.options.validateStatus = (status) {
        return true;
      };

      MsMhs msMhs = MsMhs(nim: nomorInduk, mhsPassword: password);
      Map<String, dynamic> jsonData = msMhs.toJson();

      Response response = await dio.post(
        'https://libeery-api-development.up.railway.app/api/public/loginmhs',
        data: jsonData,
        options: Options(headers: {
          'Content-Type': 'application/json',
        }),
      );

      Map<String, dynamic> loginResponse =
          msMhs.loginMhsReponseDTO(response.data);

      if (loginResponse['statusCode'] == 200) {
        // redirect to another page
        String userId = loginResponse['userId'];
        String username = loginResponse['username'];
        return [200, userId, username];
      } else {
        return [400, loginResponse['message']];
      }
    } catch (error) {
      return [400, 'Unexpected error occurred: $error'];
    }
  }
}
