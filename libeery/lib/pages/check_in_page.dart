import 'package:dotted_border/dotted_border.dart';
import 'package:flutter/material.dart';
import 'package:libeery/widgets/camera_permission.dart';

class CheckInScreen extends StatefulWidget {
  final String userID;
  final String bookingID;
  final VoidCallback onCheckInSuccess;

  const CheckInScreen({
    Key? key,
    required this.userID,
    required this.bookingID,
    required this.onCheckInSuccess,
  }) : super(key: key);

  @override
  CheckInScreenState createState() => CheckInScreenState();
}

class CheckInScreenState extends State<CheckInScreen> {
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
                  Center(
                    child: SizedBox(
                      width: 260,
                      height: 259,
                      child: DottedBorder(
                        borderType: BorderType.RRect,
                        radius: const Radius.circular(12),
                        color: Colors.grey,
                        strokeWidth: 1,
                        dashPattern: const [6, 3],
                        child: const Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Icon(
                              Icons.camera_alt,
                              size: 36,
                            ),
                            SizedBox(height: 10),
                            Text(
                              'Izinkan Akses Kamera',
                              style: TextStyle(
                                  fontSize: 12, fontWeight: FontWeight.w600),
                            ),
                            SizedBox(height: 5),
                            Text(
                              'Untuk melakukan checkout, kami memerlukan servis kameramu untuk dapat memindai barcode tertera',
                              textAlign: TextAlign.center,
                              style: TextStyle(fontSize: 10),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                  const SizedBox(height: 10),
                  ElevatedButton(
                    onPressed: () {
                      Navigator.of(context).pop();
                      widget.onCheckInSuccess(); // Notify check-in success
                      _showCameraPermissionPopup(context);
                    },
                    style: ElevatedButton.styleFrom(
                      backgroundColor: const Color(0xFFF18700),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(8),
                      ),
                    ),
                    child: const SizedBox(
                      width: 222, // Width adjustment
                      height: 32, // Height adjustment
                      child: Center(
                        child: Text(
                          'Berikan Izin Akses Kamera',
                          style: TextStyle(
                            color: Colors.white,
                            fontSize: 11.57,
                          ),
                        ),
                      ),
                    ),
                  ),
                  const SizedBox(height: 10),
                  Center(
                    child: SizedBox(
                      width: 173,
                      height: 32,
                      child: ElevatedButton(
                        onPressed: () {
                          Navigator.of(context).pop();
                        },
                        style: ElevatedButton.styleFrom(
                          backgroundColor: const Color(0xFFC75E5E),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(8),
                          ),
                        ),
                        child: const Text(
                          'Batalkan Sesi',
                          style: TextStyle(
                            color: Colors.white,
                            fontSize: 9.28,
                          ),
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  void _showCameraPermissionPopup(BuildContext context) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return CameraPermissionPopup(
          bookingID: widget.bookingID,
          userID: widget.userID,
        );
      },
    );
  }
}
