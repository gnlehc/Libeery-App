import 'package:flutter/material.dart';
import 'package:libeery/widgets/check_in_success_popup.dart';
import 'package:qr_code_scanner/qr_code_scanner.dart';
import 'package:dio/dio.dart';

class CameraPermissionPopup extends StatefulWidget {
  final String userID;
  final String bookingID;

  const CameraPermissionPopup(
      {super.key, required this.userID, required this.bookingID});

  @override
  CameraPermissionPopupState createState() => CameraPermissionPopupState();
}

class CameraPermissionPopupState extends State<CameraPermissionPopup> {
  final qrKey = GlobalKey(debugLabel: 'QR');
  QRViewController? controller;
  Barcode? barcode;
  final Dio _dio = Dio();

  @override
  void dispose() {
    controller?.dispose();
    super.dispose();
  }

  void _onQRViewCreated(QRViewController controller) {
    setState(() {
      this.controller = controller;
    });

    controller.scannedDataStream.listen((scanData) {
      if (barcode == null || barcode?.code != scanData.code) {
        setState(() {
          barcode = scanData;
        });

        _sendQRDataToBackend(widget.userID, widget.bookingID);
      }
    });
  }

  Future<void> _sendQRDataToBackend(String userID, String bookingID) async {
    try {
      final apiUrl =
          'https://libeery-api-development.up.railway.app/api/private/check-in';
      final response = await _dio.post(
        apiUrl,
        data: {
          'UserID': userID,
          'BookingID': bookingID,
        },
        options: Options(
          headers: {'Content-Type': 'application/json'},
        ),
      );

      if (response.statusCode == 200) {
        final responseData = response.data;
        if (responseData['Message'] == "Check In Successful") {
          Navigator.of(context).popUntil((route) => route.isFirst);
          _showCheckInSuccessPopup();
        } else {
          _showSnackBar('Unexpected response: ${responseData['Message']}');
        }
      } else {
        _showSnackBar(
            'Check In Failed with status code: ${response.statusCode}');
      }
    } on DioError catch (e) {
      if (e.response != null) {
        print('Error: ${e.response!.statusCode} ${e.response!.data}');
        _showSnackBar(
            'Server error: ${e.response!.statusCode} - ${e.response!.data}');
      } else {
        print('Error: $e');
        _showSnackBar('Network error: $e');
      }
    } catch (error) {
      print('Unexpected error: $error');
      _showSnackBar('Unexpected error: $error');
    }
  }

  void _showCheckInSuccessPopup() {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return CheckInSuccessPopUp();
      },
    );
  }

  void _showSnackBar(String message) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(content: Text(message)),
    );
  }

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      backgroundColor: Colors.white,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(12),
      ),
      contentPadding: const EdgeInsets.all(0),
      content: SingleChildScrollView(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Container(
              width: 300,
              height: 440,
              padding: const EdgeInsets.all(16),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  Row(
                    children: [
                      GestureDetector(
                        onTap: () {
                          Navigator.of(context).pop();
                        },
                        child: const Icon(Icons.arrow_back),
                      ),
                      const SizedBox(width: 8),
                      const Text(
                        'Mulai Sesi',
                        style: TextStyle(
                            fontSize: 16, fontWeight: FontWeight.bold),
                      ),
                    ],
                  ),
                  const SizedBox(height: 20),
                  SizedBox(
                    width: 222,
                    height: 259,
                    child: ClipRRect(
                      borderRadius: BorderRadius.circular(12),
                      child: QRView(
                        key: qrKey,
                        onQRViewCreated: _onQRViewCreated,
                      ),
                    ),
                  ),
                  const SizedBox(height: 10),
                  const Text(
                    '1. Arahkan kameramu ke barcode yang tertera pada Circulation Area.\n'
                    '2. Setelah melakukan scan barcode, kamu akan terhitung sudah check-in ke LKC.\n'
                    '3. Setelah check-in, silahkan mengambil kunci loker dan memakai loker peminjamanmu.',
                    style: TextStyle(fontSize: 7),
                    textAlign: TextAlign.justify,
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
