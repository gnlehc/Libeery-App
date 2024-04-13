import 'package:flutter/material.dart';
import 'package:qr_code_scanner/qr_code_scanner.dart';

void main(){
  runApp(const HomePage());
}

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Home Page'),
      ),
      body: const Center(
        child: BlueCard(), // Display the blue card
      ),
    );
  }
}

class BlueCard extends StatelessWidget {
   const BlueCard({super.key});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        // Show the pop-up widget when the blue card is tapped
        showDialog(
          context: context,
          builder: (BuildContext context) => PopUpWidget(),
        );
      },
      child: Container(
        width: 200,
        height: 200,
        color: Colors.blue,
        child: const Center(
          child: Text(
            'Tap Me',
            style: TextStyle(color: Colors.white, fontSize: 20),
          ),
        ),
      ),
    );
  }
}

class PopUpWidget extends StatelessWidget {
  PopUpWidget({super.key});
  
  final GlobalKey qrKey = GlobalKey(); // Key for accessing the QR code scanner

  @override
  Widget build(BuildContext context) {
    return Dialog(
      child: Container(
        padding: const EdgeInsets.all(20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisSize: MainAxisSize.min,
          children: [
            Row(
              children: [
                IconButton(
                  icon: const Icon(Icons.arrow_back),
                  onPressed: () {
                    Navigator.pop(context); // Close the pop-up and return to the previous page
                  },
                ),
                const Text(
                  'Akhiri Sesi',
                  style: TextStyle(fontSize: 18),
                ),
              ],
            ),
            const SizedBox(height: 20),
            Expanded(
              child: QRView(
                key: qrKey,
                onQRViewCreated: _onQRViewCreated,
              ),
            ),
            const SizedBox(height: 20),
            const Text(
              'Informasi tambahan',
              style: TextStyle(fontSize: 16),
            ),
          ],
        ),
      ),
    );
  }

  // Method to handle QR code scanning
  void _onQRViewCreated(QRViewController controller) {
    controller.scannedDataStream.listen((scanData) {
      // Process the scanned QR code data, e.g., navigate to a website
      print('Scanned data: ${scanData.code}');
      // Example: launchURL(scanData.code);
    });
  }
}

