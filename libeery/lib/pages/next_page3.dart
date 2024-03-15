import 'package:flutter/material.dart';
import 'package:libeery/pages/next_page2.dart';

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

  Color color1 = const Color.fromRGBO(51, 51, 51, 1);
  Color color2 = const Color.fromRGBO(217, 217, 217, 1);
  Color color3 = const Color.fromRGBO(241, 135, 0, 1);
  Color color4 = const Color.fromRGBO(197, 197, 197, 1);

 // Untuk navigate di appBar
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
            MaterialPageRoute(builder: (context) => NextPage2()), // NextPage2() ganti jadi class di bookingPageTab2 
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
            MaterialPageRoute(builder: (context) => NextPage3()), // NextPage3() ganti jadi class di bookingPageTab3
          );
          break;
         case 4:
          Navigator.push(
            context,
            MaterialPageRoute(builder: (context) => NextPage3()), // NextPage3() ganti jadi class di bookingPageTab4
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
        automaticallyImplyLeading: false, // ini buat ilangin navigationUp dari navigasi bawaan emulator androidnya biar kita bisa pake icon kita sendiri
        backgroundColor: Colors.white,
        title: Padding(
          padding: const EdgeInsets.only(top: 23.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  _buildProgressIndicator(1),
                  _buildProgressIndicator(2),
                  _buildProgressIndicator(3),
                  _buildProgressIndicator(4),
                ],
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  Padding(
                    padding: const EdgeInsets.fromLTRB(12.0, 10.0, 0, 0),
                    child: IconButton(
                      onPressed: (){
                        Navigator.of(context).pop();
                      }, 
                      icon: const Icon(Icons.arrow_back_ios),
                      ),
                    ),
                ],
              ),
            ],
          ),
        ),
      ),
      body: Container(
        color: Colors.white,
        child: Center(
            child: Text(
              'page3',
              style: TextStyle(fontSize: 24),
            ),
          ),
      ),
    );
  }
  Widget _buildProgressIndicator(int step) {
    // Memeriksa apakah kotak progresif harus diisi atau tidak
     bool filled = progressStatus[step - 1];
    // Warna kotak progresif berdasarkan status
    Color color = filled ? color3 : color4;
    return Container(
      width: 72,
      height: 4,
      margin: const EdgeInsets.symmetric(horizontal: 1),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(100),
        color: color,
        border: Border.all(color: color)
      ),
    );
  }
}