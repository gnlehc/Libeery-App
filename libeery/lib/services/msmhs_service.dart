import 'package:dio/dio.dart';
import 'package:libeery/models/msmhs_model.dart';

class MsMhsService {
  final Dio _dio = Dio();

  Future<LoginMhsResponseDTO> loginMhs(
      String nomorInduk, String password) async {
    try {
      _dio.options.validateStatus = (status) {
        return true;
      };
      final msMhs = MsMhs(nim: nomorInduk, mhsPassword: password);
      final request = msMhs.toJson();
      _printDebugInfo('Request Data', request);

      final response = await _dio.post(
        'https://libeery-api-development.up.railway.app/api/public/loginmhs',
        data: request,
        options: Options(headers: {'Content-Type': 'application/json'}),
      );

      _printDebugInfo('Response Status Code', response.statusCode);
      _printDebugInfo('Response Data', response.data);
      final loginResponse = LoginMhsResponseDTO.fromJson(response.data);
      _printDebugInfo('Parsed Response', loginResponse);
      
      return loginResponse;
    
    } catch (error) {
      _handleError(error);
      rethrow;
    }
  }

  void _printDebugInfo(String label, dynamic data) {
    print('$label: $data');
  }

  void _handleError(dynamic error) {
    print('Error occurred: $error');
  }
}
