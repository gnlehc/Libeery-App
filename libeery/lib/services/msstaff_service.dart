// ignore: depend_on_referenced_packages
import 'package:dio/dio.dart';
import 'package:libeery/models/msstaff_model.dart';

class MsStaffService {
  static Future<List<dynamic>> loginStaff(
      String nomorInduk, String password) async {
    try {
      final dio = Dio();
      dio.options.validateStatus = (status) {
        return true;
      };
      MsStaff msStaff = MsStaff(nis: nomorInduk, staffPassword: password);
      Map<String, dynamic> jsonData = msStaff.toJson();

      Response response = await dio.post(
        'https://libeery-api-development.up.railway.app/api/public/loginstaff',
        data: jsonData,
        options: Options(headers: {
          'Content-Type': 'application/json',
        }),
      );

      Map<String, dynamic> loginResponse =
          msStaff.loginStaffReponseDTO(response.data);

      if (loginResponse['statusCode'] == 200) {
        // redirect to another page
        String userId = loginResponse['userId'];
        return [200, userId];
      } else {
        return [400, loginResponse['message']];
      }
    } catch (error) {
      return [400, 'Unexpected error occurred: $error'];
    }
  }
}
