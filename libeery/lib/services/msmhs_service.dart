import 'package:dio/dio.dart';
import 'package:libeery/models/msmhs_model.dart';

class MsMhsService {
  final Dio _dio = Dio();

  Future<LoginMhsResponseDTO> loginMahasiswa(
    String nomorInduk,
    String password,
  ) async {
    try {
      final msMhs = MsMhs(nim: nomorInduk, mhsPassword: password);
      final request = msMhs.toJson();

      final response = await _dio.post(
        'https://libeery-api-development.up.railway.app/api/public/loginmhs',
        data: request,
      );

      return LoginMhsResponseDTO.fromJson(response.data);
    } catch (error) {
      throw Exception('Failed to perform login: $error');
    }
  }
}


// import 'package:dio/dio.dart';
// import 'package:libeery/models/msmhs_model.dart';

// class MsMhsService {
//   final Dio _dio = Dio();

//   Future<LoginMhsResponseDTO> loginMahasiswa(
//       String nomorInduk, String password) async {
//     try {
//       _dio.options.validateStatus = (status) {
//         return true;
//       };
//       final msMhs = MsMhs(nim: nomorInduk, mhsPassword: password);
//       final request = msMhs.toJson();
//       _printDebugInfo('Request Data', request);

//       final response = await _dio.post(
//         'https://libeery-api-development.up.railway.app/api/public/loginmhs',
//         data: request,
//       );

//       _printDebugInfo('Response Status Code', response.statusCode);
//       _printDebugInfo('Response Data', response.data);
//       LoginMhsResponseDTO loginResponse =
//           LoginMhsResponseDTO.fromJson(response.data);
//       _printDebugInfo('Parsed Response', loginResponse);

//       return loginResponse;
//     } catch (error) {
//       _handleError(error);
//       rethrow;
//     }
//   }

//   void _printDebugInfo(String label, dynamic data) {
//     print('$label: $data');
//   }

//   void _handleError(dynamic error) {
//     print('Error occurred: $error');
//   }
// }
