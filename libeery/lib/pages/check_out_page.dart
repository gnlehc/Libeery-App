import 'dart:convert';
import 'dart:io';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:libeery/widgets/check-out-success_popup.dart';
import 'package:qr_code_scanner/qr_code_scanner.dart';

class CheckOutScreen extends StatefulWidget {
  final String userID;
  final String bookingID;

  const CheckOutScreen({
    Key? key,
    required this.userID,
    required this.bookingID,
  }) : super(key: key);

  @override
  _CheckOutScreenState createState() => _CheckOutScreenState();
}

class _CheckOutScreenState extends State<CheckOutScreen> {
  final GlobalKey qrKey = GlobalKey(debugLabel: 'QR');
  QRViewController? controller;
  Barcode? barcode;
  String result = "";

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

  Future<void> _sendQRDataToBackend(String qrData) async {
    Dio dio = Dio();
    try {
      final url =
          'https://libeery-api-development.up.railway.app/api/private/check-out';

      final response = await dio.post(
        url,
        data: jsonEncode({
          'UserID': widget.userID,
          'BookingID': widget.bookingID,
          'qr_data': qrData,
        }),
        options: Options(
          headers: {'Content-Type': 'application/json'},
        ),
      );

      if (response.statusCode == 200) {
        final Map<String, dynamic> responseData = response.data;
        if (responseData['Message'] == "Check Out Successful") {
          Navigator.of(context).popUntil((route) => route.isFirst);
          _showCheckOutSuccessPopup();
          // _showSnackBar('Check Out Successful');
        } else {
          _showSnackBar('Unexpected response: ${responseData['Message']}');
        }
      } else {
        _showSnackBar('Check Out Failed');
      }
    } catch (error) {
      _showSnackBar('Error: $error');
    }
  }

  void _showCheckOutSuccessPopup() {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return CheckOutSuccessPopUp();
      },
    );
  }

  void _showSnackBar(String message) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(content: Text(message)),
    );
  }

  Widget buildResult() => Container(
        decoration: BoxDecoration(
          color: Colors.white,
        ),
        child: Text(
          barcode != null ? 'Result : ${barcode!.code}' : 'Scan a correct QR',
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
                        'Akhiri Sesi',
                        style: TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.bold,
                        ),
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
                    '2. Setelah melakukan scan barcode, kamu akan terhitung sudah check-out dari LKC.\n'
                    '3. Silahkan mengembalikan kunci loker dan meninggalkan area peminjaman.',
                    style: TextStyle(
                      fontSize: 12,
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

        _sendQRDataToBackend(result);
      }
    });
  }
}
