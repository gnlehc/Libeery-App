import 'package:flutter/material.dart';
import 'package:libeery/next_page2.dart';

void main() => runApp(MaterialApp(
  home: NextPage3(),
));

class NextPage3 extends StatefulWidget {
  const NextPage3({super.key});

  @override
  State<NextPage3> createState() => _NextPage3State();
}

class _NextPage3State extends State<NextPage3> {

  int currentStep = 3;
    List<bool> progressStatus = [false, false, true, false];
  void navigateToNextPages() {
    if (currentStep < 4) {
      setState(() {
        currentStep++; // Naikkan tahap saat ini
        progressStatus[currentStep - 1] = true; // Ubah status warna ProgressIndicator sesuai tahap saat ini
      });

      // Sesuaikan dengan navigasi ke halaman selanjutnya
      switch (currentStep) {
        case 2:
          Navigator.push(
            context,
            MaterialPageRoute(builder: (context) => NextPage2()),
          ).then((_) {
            // Reset warna ProgressIndicator yang pertama setelah kembali dari halaman 2
            setState(() {
              progressStatus[0] = false;
            });
          });
          break;
        case 3:
          Navigator.push(
            context,
            MaterialPageRoute(builder: (context) => NextPage3()),
          );
          break;
       
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[900],
      appBar: AppBar(
        backgroundColor: Colors.white,
        title: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            _buildProgressIndicator(1),
            _buildProgressIndicator(2),
            _buildProgressIndicator(3),
            _buildProgressIndicator(4),
          ],
        ),
        leading: IconButton(
          icon: const Icon(
              Icons.arrow_back_ios,
          ),
          iconSize: 20,
          onPressed: () {
            Navigator.of(context).pop();
          },
        ),
      ),
    );
  }
  Widget _buildProgressIndicator(int step) {
    // Memeriksa apakah kotak progresif harus diisi atau tidak
     bool filled = progressStatus[step - 1];
    // Warna kotak progresif berdasarkan status
    Color color = filled ? Colors.green : Colors.grey;

    return Container(
      width: 20,
      height: 20,
      margin: const EdgeInsets.symmetric(horizontal: 5),
      decoration: BoxDecoration(
        shape: BoxShape.circle,
        color: color,
        border: Border.all(color: Colors.black),
      ),
    );
  }
}