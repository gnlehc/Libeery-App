
import 'package:flutter/material.dart';
import 'package:libeery/pages/book_for_now_page.dart';
import 'package:libeery/pages/book_for_later_page.dart';



void main() {
  runApp(const BookingPageOne());
}


class BookingPageOne extends StatefulWidget {
  const BookingPageOne({super.key});

  @override
  State<BookingPageOne> createState() => _BookingPageOneState();
}

class _BookingPageOneState extends State<BookingPageOne> {


  List<bool> progressStatus = [true, false, false, false];
// di Page yang lagi dibuka, currentStep ganti ke angkaPage itu (page2 brarti currentStep = 2)
// dan ProgressStatusnya harus atur true hanya di page yang lagi dibuka

  bool card1Clicked = false;
  bool card2Clicked = false;

  Color color1 = const Color.fromRGBO(51, 51, 51, 1);
  Color color2 = const Color.fromRGBO(217, 217, 217, 1);
  Color color3 = const Color.fromRGBO(241, 135, 0, 1);
  Color color4 = const Color.fromRGBO(197, 197, 197, 1);

  Color cardColor1 = const Color.fromRGBO(217, 217, 217, 1);
  Color cardColor2 = const Color.fromRGBO(217, 217, 217, 1);

  Color textCard1 = const Color.fromRGBO(51, 51, 51, 1);
  Color textCard2 = const Color.fromRGBO(51, 51, 51, 1);

  double heightCard1 = 123;
  double widthCard1 = 285;

  double heightCard2 = 123;
  double widthCard2 = 285;

  double heightCard = 130;
  double widthCard = 300;

  void changeCard1(){
    setState(() {

      card1Clicked = true;
      card2Clicked = false;

      cardColor1 = color1;
      textCard1 = color2;
      heightCard1 = heightCard;
      widthCard1 = widthCard;

      cardColor2 = color2;
      textCard2 = color1;
      heightCard2 = 123;
      widthCard2 = 285;
    });
  }

  void changeCard2(){
    setState(() {
      card1Clicked = false;
      card2Clicked = true;

      cardColor2 = color1;
      textCard2 = color2;
      heightCard2 = heightCard;
      widthCard2 = widthCard;

      cardColor1 = color2;
      textCard1 = color1;
      heightCard1 = 123;
      widthCard1 = 285;
    });
  }


// Untuk navigate di ElevatedButton 'Selanjutnya'
  void navigateToNextPage(BuildContext context) {
    if (card1Clicked) {
      Navigator.push(
        context,
        MaterialPageRoute(builder: (context) => const BookForNow()), //  NextPage2() ganti jadi class di bookingPageTab2 yg fornow
      );
    } else if (card2Clicked) {
      Navigator.push(
        context,
        MaterialPageRoute(builder: (context) => const BookForLater()), //  NextPage3() ganti jadi class di bookingPageTab2 yg forlater
      );
    }
  }

  Widget buildProgressIndicator(int step) {
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

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false, // ini buat ilangin navigationUp dari navigasi bawaan emulator androidnya biar kita bisa pake icon kita sendiri
        flexibleSpace: const Image(
          image: AssetImage('assets/image/whitebackground.png'),
          fit: BoxFit.cover,
        ), 
        backgroundColor: Colors.transparent,
        title: Padding(
          padding: const EdgeInsets.only(top: 23.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  buildProgressIndicator(1),
                  buildProgressIndicator(2),
                  buildProgressIndicator(3),
                  buildProgressIndicator(4),
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
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Padding(
              padding: const EdgeInsets.fromLTRB(45.0, 20.0, 45.0, 5.0),
              child: Text(
                'Pilih Jadwal Kunjunganmu!',
                style: TextStyle(
                  fontFamily: 'Montserrat',
                  fontWeight: FontWeight.w600,
                  fontSize: 16.0,
                  color: color1,
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.fromLTRB(45.0, 2.0, 45.0, 5.0),
              child: Text(
                'Kamu dapat memilih apakah kamu akan mengunjungi LKC untuk saat ini atau untuk beberapa jam kedepan. Pastikan jadwal yang kamu pilih sehingga tidak mengganggu jam kuliahmu.',
                style: TextStyle(
                  fontFamily: 'Montserrat',
                  color: color1,
                  fontWeight: FontWeight.w300,
                  fontSize: 11.0,
                ),
                textAlign: TextAlign.justify,
              ),
            ),
            const SizedBox(height: 10.0),
            Center(
              child: GestureDetector(
                onTap: () {
                  changeCard1();
                },
                child: Card(
                  elevation: 3,
                  margin: const EdgeInsets.all(10),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(15),
                    side: const BorderSide(
                      color: Color.fromRGBO(187, 187, 187, 1), 
                      width: 1)
                  ),
                  color:  cardColor1,
                  child: SizedBox(
                    width: widthCard1,
                    height: heightCard1,
                    child: Row(
                      children: [
                        Padding(
                          padding: const EdgeInsets.fromLTRB(20.0, 10.0, 5.0, 10.0),
                          child: SizedBox(
                            height: 107,
                            width: 96,
                            child: Image.asset('assets/image/libeery1-bookfornow.png'),
                          ),
                        ),
                        Expanded(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.end,
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Padding(
                                padding: const EdgeInsets.fromLTRB(0, 0, 20.0, 5.0),
                                child: Text(
                                  'Butuh Sekarang Nih...',
                                  style: TextStyle(
                                    fontSize: 12.0,
                                    fontFamily: 'Montserrat',
                                    color: textCard1,
                                    fontWeight: FontWeight.w600,
                                  ),
                                  textAlign: TextAlign.right,
                                ),
                              ),
                              Padding(
                                padding: const EdgeInsets.fromLTRB(0, 0, 20.0, 0),
                                child: Text(
                                  'Aku ingin mengunjungi perpustakaan sekarang karena ada kepentingan mendadak.',
                                  style: TextStyle(
                                      fontSize: 8.70,
                                      fontFamily: 'Montserrat',
                                      fontWeight: FontWeight.w300,
                                      color: textCard1,
                                      overflow: TextOverflow.clip
                                  ),
                                  textAlign: TextAlign.right,
                                ),
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            ),
        
            Center(
              child: GestureDetector(
                onTap: () {
                  changeCard2();
                },
                child: Card(
                  elevation: 3,
                  margin: const EdgeInsets.all(10),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(15),
                    side: const BorderSide(
                      color: Color.fromRGBO(187, 187, 187, 1), 
                      width: 1)
                  ),
                  color:  cardColor2,
                  child: SizedBox(
                    width: widthCard2,
                    height: heightCard2,
                    child: Row(
                      children: [
                        Expanded(
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Padding(
                                padding: const EdgeInsets.fromLTRB(20.0, 0, 2.0, 5.0),
                                child: Text(
                                  'Untuk Nanti Deh...',
                                  style: TextStyle(
                                    fontSize: 13.0,
                                    fontFamily: 'Montserrat',
                                    color: textCard2,
                                    fontWeight: FontWeight.w600,
                                  ),
                                  textAlign: TextAlign.left,
                                ),
                              ),
                              Padding(
                                padding: const EdgeInsets.fromLTRB(20.0, 0, 2.0, 0),
                                child: Text(
                                  'Aku ingin mereservasi slot loker dulu untuk kunjunganku nanti, aku pasti akan datang kok.',
                                  style: TextStyle(
                                      fontSize: 8.50,
                                      fontFamily: 'Montserrat',
                                      color: textCard2,
                                      fontWeight: FontWeight.w300,
                                      overflow: TextOverflow.clip
                                  ),
                                  textAlign: TextAlign.left,
                                ),
                              ),
                            ],
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.fromLTRB(5.0, 10.0, 20.0, 10.0),
                          child: SizedBox(
                            height: 107,
                            width: 96,
                            child: Image.asset('assets/image/libeery2-bookforlater.png'),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            ),
            const SizedBox(height: 10.0),
            Center(
              child: ElevatedButton(
                onPressed: () {
                  navigateToNextPage(context);
                },
                style: ElevatedButton.styleFrom(
                  backgroundColor: color3,
                  fixedSize: const Size(136, 33),
                  elevation: 5,
                ),
                child: const Text(
                    'Selanjutnya',
                    style: TextStyle(
                      fontSize: 14.0,
                      fontWeight: FontWeight.w600,
                      color: Colors.white,
                      fontFamily: 'Montserrat',
                    ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

