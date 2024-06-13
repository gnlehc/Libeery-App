import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'dart:convert';
import 'package:dio/dio.dart';
import 'package:libeery/styles/style.dart';
import 'package:logger/logger.dart';
import 'package:libeery/pages/booking_page_three.dart';

void main() {
  runApp(const BookForNow());
}

class SessionVisitTime {
  final String userID;
  final String startSession;
  final String endSession;
  final int lokerID;

  SessionVisitTime({
    required this.userID,
    required this.startSession,
    required this.endSession,
    required this.lokerID,
  });

  factory SessionVisitTime.fromJson(Map<String, dynamic> json) {
    return SessionVisitTime(
      userID: json['UserID'],
      startSession: json['StartSession'],
      endSession: json['EndSession'],
      lokerID: json['LokerID'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'UserID': userID,
      'StartSession': startSession,
      'EndSession': endSession,
      'LokerID': lokerID,
    };
  }
}

class BookForNow extends StatefulWidget {
  const BookForNow({super.key});

  @override
  State<BookForNow> createState() => _BookForNowState();
}

class _BookForNowState extends State<BookForNow> {
  List<bool> progressStatus = [false, true, false, false];

  final Logger logger = Logger(
    printer: PrettyPrinter(), // Printer untuk menata keluaran log
    level: Level.debug, // Level logging yang digunakan
  );
  String? errorMessage;

  late TimeOfDay startTime;
  late TimeOfDay endTime;
  late int selectedHour;
  late int selectedMinute;

  @override
  void initState() {
    super.initState();
    startTime = TimeOfDay.now();
    endTime = TimeOfDay(hour: TimeOfDay.now().hour + 1, minute: 00);
    selectedHour = endTime.hour;
    selectedMinute = endTime.minute;
  }

  Widget buildProgressIndicator(int step) {
    // Memeriksa apakah kotak progresif harus diisi atau tidak
    bool filled = progressStatus[step - 1];
    // Warna kotak progresif berdasarkan status
    Color color = filled
        ? AppColors.orange
        : AppColors.lightGray;
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

  Future<String?> postSessionVisitTime(
      SessionVisitTime sessionVisitTime) async {
    const url =
        'https://libeery-api-development.up.railway.app/api/private/bookSession-fornow';

    try {
      final dio = Dio();
      dio.options.validateStatus = (status) {
        return true;
      };

      Response response = await dio.post(
        url,
        data: json.encode(sessionVisitTime.toJson()),
        options: Options(headers: {
          'Content-Type': 'application/json',
        }),
      );

      if (response.statusCode == 200) {
        return null;
      } else {
        return response.data['Message'] ?? 'Unknown error occured';
      }
    } catch (error) {
      return 'Unexpected error occured: $error';
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
        // ini buat ilangin navigationUp dari navigasi bawaan emulator androidnya biar kita bisa pake icon kita sendiri
        flexibleSpace: const Image(
          image: AssetImage('assets/image/whitebackground.png'),
          fit: BoxFit.cover,
        ),
        backgroundColor: Colors.transparent,
        title: Padding(
          padding: const EdgeInsets.only(top: Spacing.small),
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
              const Padding(
                padding: EdgeInsets.only(left: Spacing.large),
                child: Text(
                  'Pilih Waktu Akhir Kunjunganmu!',
                  style: TextStyle(
                    fontFamily: 'Montserrat',
                    fontWeight: FontWeights.bold,
                    fontSize: FontSizes.subtitle,
                    color: AppColors.black,
                  ),
                ),
              ),
              const Padding(
                padding: EdgeInsets.fromLTRB(Spacing.large, 5.0, Spacing.large, 0),
                child: Text(
                  'Pastikan kamu memilih waktu yang tepat untuk mengakhiri kunjungan. Tips: jika tidak memungkinkan untuk keluar LKC tepat waktu, kamu dapat melebihi durasi kunjunganmu.',
                  style: TextStyle(
                    fontFamily: 'Montserrat',
                    color: AppColors.black,
                    fontWeight: FontWeights.regular,
                    fontSize: FontSizes.description,
                  ),
                  textAlign: TextAlign.justify,
                ),
              ),
              const SizedBox(height: Spacing.medium),
              Padding(
                padding: const EdgeInsets.all(0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    SizedBox(
                      height: 200,
                      width: 80,
                      child: Container(
                        decoration: const BoxDecoration(
                          color: Colors.white,
                        ),
                        child: CupertinoPicker(
                          selectionOverlay: Container(
                            decoration: const BoxDecoration(
                                border: Border(
                              top: BorderSide(
                                  color: AppColors.blue),
                              bottom: BorderSide(
                                  color: AppColors.blue),
                            )),
                          ),
                          backgroundColor: Colors.white,
                          itemExtent: 75,
                          looping: true,
                          scrollController: FixedExtentScrollController(
                              initialItem: selectedHour + 9),
                          onSelectedItemChanged: (hourIndex) {
                            setState(() {
                              selectedHour = hourIndex + 9;
                            });
                          },
                          children: List.generate(10, (index) {
                            final hour = index + 9;
                            final hourText = hour < 10 ? '0$hour' : '$hour';
                            return Center(
                              child: Text(
                                hourText,
                                style: const TextStyle(
                                  fontFamily: 'Montserrat',
                                  fontWeight: FontWeights.medium,
                                  color: AppColors.black,
                                  fontSize: FontSizes.extraLarge,
                                ),
                              ),
                            );
                          }),
                        ),
                      ),
                    ),
                    SizedBox(
                      height: 200,
                      width: 80,
                      child: Container(
                        decoration: const BoxDecoration(
                          color: Colors.white,
                        ),
                        child: CupertinoPicker(
                          selectionOverlay: Container(
                            decoration: const BoxDecoration(
                                border: Border(
                              top: BorderSide(
                                  color: AppColors.blue),
                              bottom: BorderSide(
                                  color: AppColors.blue),
                              left: BorderSide(
                                  color: AppColors.blue,
                                  width: 0.5),
                            )),
                          ),
                          backgroundColor: Colors.white,
                          itemExtent: 75,
                          looping: true,
                          scrollController: FixedExtentScrollController(
                              initialItem: selectedMinute),
                          onSelectedItemChanged: (minuteIndex) {
                            setState(() {
                              selectedMinute = minuteIndex;
                            });
                          },
                          children: List.generate(1, (index) {
                            final minute = index * 0;
                            final minuteText =
                                minute < 10 ? '0$minute' : '$minute';
                            return Center(
                              child: Text(
                                minuteText,
                                style: const TextStyle(
                                    fontFamily: 'Montserrat',
                                    fontWeight: FontWeights.medium,
                                    color: AppColors.black,
                                    fontSize: FontSizes.extraLarge),
                              ),
                            );
                          }),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              const SizedBox(height: Spacing.medium),
              const Padding(
                padding: EdgeInsets.only(left: Spacing.large),
                child: Text(
                  'Waktu Kunjungan',
                  style: TextStyle(
                    fontFamily: 'Montserrat',
                    fontWeight: FontWeights.regular,
                    fontSize: FontSizes.description,
                    color: AppColors.black,
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.fromLTRB(Spacing.large, 5.0, Spacing.large, 0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      'Mulai: ${startTime.hour.toString().padLeft(2, '0')}:${startTime.minute.toString().padLeft(2, '0')} WIB',
                      style: const TextStyle(
                          color: AppColors.black,
                          fontFamily: 'Montserrat',
                          fontSize: FontSizes.medium,
                          fontWeight: FontWeights.medium),
                    ),
                    Text(
                      'Selesai: ${selectedHour.toString().padLeft(2, '0')}:${selectedMinute.toString().padLeft(2, '0')} WIB',
                      style: const TextStyle(
                          color: AppColors.black,
                          fontFamily: 'Montserrat',
                          fontSize: FontSizes.medium,
                          fontWeight: FontWeights.medium),
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 5.0),
              const Divider(
                thickness: 0.5,
                color: AppColors.black,
                indent: 30.0,
                endIndent: 30.0,
              ),
              const SizedBox(height: Spacing.small),
              Center(
                child: ElevatedButton(
                  onPressed: () async {
                    DateTime startSessionTime = DateTime(
                      DateTime.now().year,
                      DateTime.now().month,
                      DateTime.now().day,
                      startTime.hour,
                      startTime.minute,
                    );

                    DateTime endSessionTime = DateTime(
                      DateTime.now().year,
                      DateTime.now().month,
                      DateTime.now().day,
                      selectedHour,
                      selectedMinute,
                    );

                  if(endSessionTime.isBefore(startSessionTime)){
                    setState(() {
                      errorMessage = "Waktu sesi sudah lewat";
                    });
                  }
                  else{
                    Navigator.push(
                      context,
                      MaterialPageRoute(builder: (context) => const BookingPage3(previousPage: BookForNow(),)),
                    );

                      SessionVisitTime sessionVisitTime = SessionVisitTime(
                        userID: '102b1784-5575-41e0-9175-795fc92455db',
                        startSession: startSessionTime.toIso8601String(),
                        endSession: endSessionTime.toIso8601String(),
                        lokerID: 40,
                      );

                      logger.d('startTime : $startSessionTime');
                      logger.d('endTime : $endSessionTime');

                      postSessionVisitTime(sessionVisitTime).then((_) {
                        logger.d('Berhasil post ke API');
                      }).catchError((error) {
                        setState(() {
                          logger.d('Gagal post ke API: $error');
                        });
                      });
                    }
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
              const SizedBox(height: 2.0),
              Padding(
                padding: const EdgeInsets.only(bottom: Spacing.small),
                child: Center(
                  child: errorMessage != null
                      ? Text(
                          errorMessage!,
                          style: const TextStyle(
                              fontFamily: 'Montserrat',
                              fontSize: FontSizes.description,
                              fontWeight: FontWeights.regular,
                              color:AppColors.red),
                        )
                      : const SizedBox(),
                ),
              ),
              Center(
                child: GestureDetector(
                  onTap: () {
                    Navigator.pushNamed(context, '/bookingone');
                  },
                  child: const Text(
                    'Sebelumnya...',
                    style: TextStyle(
                      fontFamily: 'Montserrat',
                      fontSize: FontSizes.description,
                      fontWeight: FontWeights.regular,
                      decoration: TextDecoration.underline,
                      color: AppColors.oldGray,
                      decorationThickness: 0.2,
                    ),
                  ),
                ),
              ),
            ]),
      ),
    );
  }
}
