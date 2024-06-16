import 'dart:io';
import 'package:flutter/material.dart';
import 'package:qr_code_scanner/qr_code_scanner.dart';
import 'package:dio/dio.dart';
import 'package:libeery/services/msuser_service.dart';

class CameraPermissionPopup extends StatefulWidget {
  const CameraPermissionPopup({super.key});

  @override
  CameraPermissionPopupState createState() => CameraPermissionPopupState();
}

class CameraPermissionPopupState extends State<CameraPermissionPopup> {
  final qrKey = GlobalKey(debugLabel: 'QR');
  QRViewController? controller;
  Barcode? barcode;
  String result = "";

  final MsUserService _msUserService = MsUserService();
  final Dio _dio = Dio();

  @override
  void dispose() {
    controller?.dispose();
    super.dispose();
  }

  @override
  void reassemble() async {
    super.reassemble();
    if (Platform.isAndroid) {
      await controller?.pauseCamera();
    }
    controller?.resumeCamera();
  }

  Future<void> _sendQRDataToBackend(
      String userID, String bookingID, String qrData) async {
    try {
      final response = await _dio.post(
        'https://libeery-api-development.up.railway.app/api/private/check-in',
        data: {
          'UserID': userID,
          'BookingID': bookingID,
          'qr_data': qrData,
        },
        options: Options(
          headers: {'Content-Type': 'application/json'},
        ),
      );

      if (response.statusCode == 200) {
        final responseData = response.data;
        if (responseData['Message'] == "Check In Successfull") {
          _showSnackBar('Check In Successful');
        } else {
          _showSnackBar('Unexpected response: ${responseData['Message']}');
        }
      } else {
        _showSnackBar(
            'Check In Failed with status code: ${response.statusCode}');
      }
    } on DioException catch (e) {
      if (e.response != null) {
        // Log detail error response dari server
        print('Error: ${e.response?.statusCode} ${e.response?.data}');
        _showSnackBar(
            'Server error: ${e.response?.statusCode} - ${e.response?.data}');
      } else {
        // Log detail error jika tidak ada response
        print('Error: $e');
        _showSnackBar('Network error: $e');
      }
    } catch (error) {
      _showSnackBar('Unexpected error: $error');
    }
  }

  void _showSnackBar(String message) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(content: Text(message)),
    );
  }

  Widget buildResult() => Container(
        decoration: const BoxDecoration(
          color: Colors.white,
        ),
        child: Text(
          barcode != null ? 'Result : ${barcode!.code}' : 'Scan a correct qr',
          style: const TextStyle(
            fontSize: 16,
          ),
        ),
      );

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
                  buildResult(),
                  const SizedBox(height: 10),
                  const Text(
                    '1. Arahkan kameramu ke barcode yang tertera pada Circulation Area.\n'
                    '2. Setelah melakukan scan barcode, kamu akan terhitung sudah check-in ke LKC.\n'
                    '3. Setelah check-in, silahkan mengambil kunci loker dan memakai loker peminjamanmu.',
                    style: TextStyle(
                      fontSize: 7,
                    ),
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

  void _onQRViewCreated(QRViewController controller) {
    setState(() {
      this.controller = controller;
    });

    controller.scannedDataStream.listen((scanData) {
      if (barcode == null || barcode?.code != scanData.code) {
        setState(() {
          barcode = scanData;
          result = scanData.code!;
        });

        // Ambil data user booking session dari API
        _msUserService
            .usersBookedSessions("88cb5eba-2aca-4944-871a-f701e76edd1b")
            .then((allUserBookedSession) {
          // Lakukan sesuatu dengan data booking session yang didapatkan
          const bookingID = "9e3876da-e850-442b-8fa0-c9c3e3fad840";

          // Mengirim data QR ke backend
          _sendQRDataToBackend(
              "88cb5eba-2aca-4944-871a-f701e76edd1b", bookingID, result);
        }).catchError((error) {
          _showSnackBar('Failed to load user booked sessions: $error');
        });
      }
    });
  }
}
