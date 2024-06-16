import 'package:flutter/material.dart';
import 'package:libeery/pages/book_for_now_page.dart';
import 'package:libeery/pages/book_for_later_page.dart';
import 'package:libeery/styles/style.dart';

// void main() {
//   runApp(const BookingPageOne());
// }

class BookingPageOne extends StatefulWidget {
  final String userId;
  final String username;
  const BookingPageOne(
      {super.key, required this.userId, required this.username});

  @override
  State<BookingPageOne> createState() => _BookingPageOneState();
}

class _BookingPageOneState extends State<BookingPageOne> {
  List<bool> progressStatus = [true, false, false, false];

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

  double heightCard1 = 140;
  double widthCard1 = 340;

  double heightCard2 = 140;
  double widthCard2 = 340;

  double heightCard = 150;
  double widthCard = 350;

  void changeCard1() {
    setState(() {
      card1Clicked = true;
      card2Clicked = false;

      cardColor1 = AppColors.black;
      textCard1 = AppColors.white;
      heightCard1 = heightCard;
      widthCard1 = widthCard;

      cardColor2 = AppColors.white;
      textCard2 = AppColors.black;
      heightCard2 = 140;
      widthCard2 = 340;
    });
  }

  void changeCard2() {
    setState(() {
      card1Clicked = false;
      card2Clicked = true;

      cardColor2 = AppColors.black;
      textCard2 = AppColors.white;
      heightCard2 = heightCard;
      widthCard2 = widthCard;

      cardColor1 = AppColors.white;
      textCard1 = AppColors.black;
      heightCard1 = 140;
      widthCard1 = 340;
    });
  }

// Untuk navigate di ElevatedButton 'Selanjutnya'
  void navigateToNextPage(BuildContext context) {
    if (card1Clicked) {
      Navigator.push(
        context,
        MaterialPageRoute(
            builder: (context) => BookForNow(
                  username: widget.username,
                  userId: widget.userId,
                )), //  NextPage2() ganti jadi class di bookingPageTab2 yg fornow
      );
    } else if (card2Clicked) {
      Navigator.push(
        context,
        MaterialPageRoute(
            builder: (context) => BookForLater(
                  username: widget.username,
                  userId: widget.userId,
                )), //  NextPage3() ganti jadi class di bookingPageTab2 yg forlater
      );
    }
  }

  Widget buildProgressIndicator(int step) {
    // Memeriksa apakah kotak progresif harus diisi atau tidak
    bool filled = progressStatus[step - 1];
    // Warna kotak progresif berdasarkan status
    Color color = filled ? AppColors.orange : AppColors.lightGray;
    return Container(
      width: 80,
      height: 4,
      margin: const EdgeInsets.symmetric(horizontal: 1),
      decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(100),
          color: color,
          border: Border.all(color: color)),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading:
            false, // ini buat ilangin navigationUp dari navigasi bawaan emulator androidnya biar kita bisa pake icon kita sendiri
        flexibleSpace: const Image(
          image: AssetImage('assets/image/whitebackground.png'),
          fit: BoxFit.cover,
        ),
        backgroundColor: Colors.transparent,
        title: Padding(
          padding: const EdgeInsets.only(top: Spacing.large),
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
                    padding: const EdgeInsets.only(left: Spacing.small),
                    child: IconButton(
                      onPressed: () {
                        Navigator.pop(context);
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
      body: Center(
        child: Container(
          color: Colors.white,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              const Padding(
                padding:
                    EdgeInsets.fromLTRB(Spacing.large, 0, Spacing.large, 0),
                child: Text(
                  'Pilih Jadwal Kunjunganmu!',
                  style: TextStyle(
                    fontFamily: 'Montserrat',
                    fontWeight: FontWeights.bold,
                    fontSize: FontSizes.subtitle,
                    color: AppColors.black,
                  ),
                ),
              ),
              const SizedBox(height: 5.0),
              const Padding(
                padding:
                    EdgeInsets.fromLTRB(Spacing.large, 0, Spacing.large, 0),
                child: Text(
                  'Kamu dapat memilih apakah kamu akan mengunjungi LKC untuk saat ini atau untuk beberapa jam kedepan. Pastikan jadwal yang kamu pilih sehingga tidak mengganggu jam kuliahmu.',
                  style: TextStyle(
                    fontFamily: 'Montserrat',
                    color: AppColors.black,
                    fontWeight: FontWeights.regular,
                    fontSize: FontSizes.description,
                  ),
                  textAlign: TextAlign.justify,
                ),
              ),
              const SizedBox(height: Spacing.small),
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
                            color: AppColors.lightGray, width: 1)),
                    color: cardColor1,
                    child: SizedBox(
                      width: widthCard1,
                      height: heightCard1,
                      child: Row(
                        children: [
                          Padding(
                            padding: const EdgeInsets.fromLTRB(Spacing.small,
                                Spacing.small, 2.0, Spacing.small),
                            child: SizedBox(
                              height: 107,
                              width: 100,
                              child: Image.asset(
                                  'assets/image/libeery1-bookfornow.png'),
                            ),
                          ),
                          Expanded(
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.end,
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Padding(
                                  padding: const EdgeInsets.fromLTRB(
                                      0, 0, Spacing.medium, 5.0),
                                  child: Text(
                                    'Butuh Sekarang Nih...',
                                    style: TextStyle(
                                      fontSize: FontSizes.medium,
                                      fontFamily: 'Montserrat',
                                      color: textCard1,
                                      fontWeight: FontWeights.bold,
                                    ),
                                    textAlign: TextAlign.right,
                                  ),
                                ),
                                Padding(
                                  padding: const EdgeInsets.only(
                                      right: Spacing.medium),
                                  child: Text(
                                    'Aku ingin mengunjungi perpustakaan sekarang karena ada kepentingan mendadak.',
                                    style: TextStyle(
                                        fontSize: FontSizes.description,
                                        fontFamily: 'Montserrat',
                                        fontWeight: FontWeights.regular,
                                        color: textCard1,
                                        overflow: TextOverflow.clip),
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
                            color: AppColors.lightGray, width: 1)),
                    color: cardColor2,
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
                                  padding: const EdgeInsets.fromLTRB(
                                      Spacing.medium, 0, 0, 5.0),
                                  child: Text(
                                    'Untuk Nanti Deh...',
                                    style: TextStyle(
                                      fontSize: FontSizes.medium,
                                      fontFamily: 'Montserrat',
                                      color: textCard2,
                                      fontWeight: FontWeights.bold,
                                    ),
                                    textAlign: TextAlign.left,
                                  ),
                                ),
                                Padding(
                                  padding: const EdgeInsets.only(
                                      left: Spacing.medium),
                                  child: Text(
                                    'Aku ingin mereservasi slot loker dulu untuk kunjunganku nanti, aku pasti akan datang kok.',
                                    style: TextStyle(
                                        fontSize: FontSizes.description,
                                        fontFamily: 'Montserrat',
                                        color: textCard2,
                                        fontWeight: FontWeights.regular,
                                        overflow: TextOverflow.clip),
                                    textAlign: TextAlign.left,
                                  ),
                                ),
                              ],
                            ),
                          ),
                          Padding(
                            padding: const EdgeInsets.fromLTRB(2.0,
                                Spacing.small, Spacing.small, Spacing.small),
                            child: SizedBox(
                              height: 107,
                              width: 100,
                              child: Image.asset(
                                  'assets/image/libeery2-bookforlater.png'),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
              ),
              const SizedBox(height: Spacing.medium),
              Center(
                child: ElevatedButton(
                  onPressed: () {
                    navigateToNextPage(context);
                  },
                  style: ElevatedButton.styleFrom(
                    backgroundColor: AppColors.orange,
                    fixedSize: const Size(140, 30),
                    elevation: 5,
                  ),
                  child: const Text(
                    'Selanjutnya',
                    style: TextStyle(
                      fontSize: FontSizes.medium,
                      fontWeight: FontWeights.medium,
                      color: AppColors.white,
                      fontFamily: 'Montserrat',
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
