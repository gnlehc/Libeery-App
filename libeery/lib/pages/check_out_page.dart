import 'dart:io';
import 'dart:convert'; // Untuk jsonEncode
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:http/http.dart' as http;
import 'package:qr_code_scanner/qr_code_scanner.dart';

class CheckOutScreen extends StatefulWidget {
  const CheckOutScreen({super.key});

  @override
  CheckOutScreenState createState() => CheckOutScreenState();
}

class CheckOutScreenState extends State<CheckOutScreen> {
  final qrKey = GlobalKey(debugLabel: 'QR');
  QRViewController? controller;
  Barcode? barcode;
  String result = "";

  @override
  void dispose() {
    controller?.dispose();
    super.dispose();
  }

  // In order to get hot reload to work we need to pause the camera if the platform is android
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
      // Ganti URL backend sesuai dengan URL backend kita nih
      final url = Uri.parse(
          'https://libeery-api-development.up.railway.app/api/private/check-out');

      // Misalkan kita ngirim data QR ke backend dengan menggunakan metode POST
      final response = await http.post(
        url,
        body: jsonEncode({
          'UserID': userID,
          'BookingID': bookingID,
          'qr_data': qrData,
        }),
        headers: {'Content-Type': 'application/json'},
      );

      // Respon dari backendnya
      if (response.statusCode == 200) {
        final Map<String, dynamic> responseData = jsonDecode(response.body);
        if (responseData['Message'] == "Check In Successfull") {
          _showSnackBar('Check Out Successful');
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
            fontSize: 8,
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
        const userID = "88cb5eba-2aca-4944-871a-f701e76edd1b";
        const bookingID = "9e3876da-e850-442b-8fa0-c9c3e3fad840";

        _sendQRDataToBackend(userID, bookingID, result);
      }
    });
  }
}
