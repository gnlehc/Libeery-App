// ignore: depend_on_referenced_packages
import 'package:dio/dio.dart';
import 'package:libeery/models/msstaff_model.dart';

class MsStaffService {
  final Dio _dio = Dio();
  
  Future<LoginStaffResponseDTO> loginStaff(String nomorInduk, String password) async {
  try {
    _dio.options.validateStatus = (status) {
     return true;
    };
    final msStaff = MsStaff(nis: nomorInduk, staffPassword: password);
    final request = msStaff.toJson();
    _printDebugInfo('Request Data', request);

    final response = await _dio.post(
      'https://libeery-api-development.up.railway.app/api/public/loginstaff',
      data: request,
      options: Options(headers: {'Content-Type': 'application/json'}),
    );
    _printDebugInfo('Response Status Code', response.statusCode);
    _printDebugInfo('Response Data', response.data);
    
    // Parse response data
    final loginResponse = LoginStaffResponseDTO.fromJson(response.data);
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
