import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'dart:convert';
import 'package:dio/dio.dart';
import 'package:logger/logger.dart';
import 'package:libeery/pages/booking_page_three.dart';


void main() {
  runApp(const BookForNow());
}

class SessionVisitTime{
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

  factory SessionVisitTime.fromJson(Map<String, dynamic> json){
    return SessionVisitTime(
      userID: json['UserID'],
      startSession: json['StartSession'], 
      endSession: json['EndSession'],
      lokerID: json['LokerID'],
    );
  }

  Map<String, dynamic> toJson(){
    return {
      'UserID' : userID,
      'StartSession' : startSession,
      'EndSession' : endSession,
      'LokerID' : lokerID,
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

  Color color1 = const Color.fromRGBO(51, 51, 51, 1);
  Color color2 = const Color.fromRGBO(217, 217, 217, 1);
  Color color3 = const Color.fromRGBO(241, 135, 0, 1);
  Color color4 = const Color.fromRGBO(197, 197, 197, 1);  
  Color color5 = const Color.fromRGBO(0, 151, 218, 1);

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
    selectedMinute= endTime.minute;
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

  Future<String?> postSessionVisitTime( SessionVisitTime sessionVisitTime) async{
    const url ='https://libeery-api-development.up.railway.app/api/private/bookSession-fornow';

       try{
      final dio = Dio();
      dio.options.validateStatus = (status){
        return true;
      };

      Response response = await dio.post(
        url,
        data: json.encode(sessionVisitTime.toJson()),
        options: Options(headers: {
          'Content-Type' : 'application/json',
        }),
      );

      if(response.statusCode == 200){
        return null;
        
      }else{
        return response.data['Message'] ?? 'Unknown error occured';
      }
    }catch(error){
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
            const Padding(
              padding: EdgeInsets.fromLTRB(45.0, 20.0, 0, 5.0),
              child: Text(
                'Pilih Waktu Akhir Kunjunganmu!',
                style: TextStyle(
                  fontFamily: 'Montserrat',
                  fontWeight: FontWeight.w700,
                  fontSize: 17.0,
                  color: Colors.black,
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.fromLTRB(45.0, 2.0, 45.0, 5.0),
              child: Text(
                'Pastikan kamu memilih waktu yang tepat untuk mengakhiri kunjungan. Tips: jika tidak memungkinkan untuk keluar LKC tepat waktu, kamu dapat melebihi waktunya saja.',
                style: TextStyle(
                  fontFamily: 'Montserrat',
                  color: color1,
                  fontWeight: FontWeight.w400,
                  fontSize: 12.0,
                ),
                textAlign: TextAlign.justify,
              ),
            ),
            const SizedBox(height: 26.0),
            Padding(
              padding: const EdgeInsets.all(0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  SizedBox(
                    height:200,
                    width:80,
                    child: Container(
                      decoration: const BoxDecoration(
                        color: Colors.white,
                      ),
                      child: CupertinoPicker(
                        selectionOverlay: Container(
                        decoration: const BoxDecoration(
                          border: Border(
                            top: BorderSide(color: Color.fromRGBO(0, 151, 218, 1)),
                            bottom: BorderSide(color: Color.fromRGBO(0, 151, 218, 1)),
                          )
                        ),
                      ),
                        backgroundColor: Colors.white,
                        itemExtent: 75,
                        looping: true,
                        scrollController: FixedExtentScrollController(
                          initialItem: selectedHour + 9
                        ),
                        onSelectedItemChanged: (hourIndex){
                          setState(() {
                            selectedHour = hourIndex + 9 ;
                          });
                        },
                        children: List.generate(10, (index){
                          final hour = index + 9;
                          final hourText = hour < 10 ? '0$hour' : '$hour';
                          return Center(
                            child: Text(
                              hourText,
                              style: const TextStyle(
                                fontFamily: 'Montserrat',
                                fontWeight: FontWeight.w500,
                                color: Colors.black,
                                fontSize: 36.0,
                                ),
                            ),
                          );
                        }), 
                      ),
                    ),
                  ),
                  SizedBox(
                    height: 200,
                    width:80,
                    child: Container(
                      decoration: const  BoxDecoration(
                        color: Colors.white,
                      ),
                    child: CupertinoPicker(
                      selectionOverlay: Container(
                        decoration: const BoxDecoration(
                          border: Border(
                            top: BorderSide(color: Color.fromRGBO(0, 151, 218, 1)),
                            bottom: BorderSide(color: Color.fromRGBO(0, 151, 218, 1)),
                            left: BorderSide(color: Color.fromRGBO(0, 151, 218, 1), width: 0.5),
                          )
                        ),
                      ),
                      backgroundColor: Colors.white,
                      itemExtent: 75,
                      looping: true,
                      scrollController: FixedExtentScrollController(
                        initialItem: selectedMinute
                      ),
                      onSelectedItemChanged: (minuteIndex){
                        setState(() {
                          selectedMinute = minuteIndex;
                        });
                      }, 
                      children: List.generate(1, (index){
                        final minute = index*0;
                        final minuteText = minute < 10 ? '0$minute' : '$minute';
                        return Center(
                          child: Text(
                            minuteText,
                            style: const TextStyle(
                              fontFamily: 'Montserrat',
                              fontWeight: FontWeight.w500,
                              color: Colors.black,
                              fontSize: 36.0
                              ),
                          ),
                        );
                      }),
                      ),
                    ),
                  ),
                ],
              ),
            ),
            const SizedBox(height: 26.0),
            const Padding(
              padding:  EdgeInsets.fromLTRB(45, 0, 0, 5.0),
              child: Text(
                'Waktu Kunjungan',
                style: TextStyle(
                  fontFamily: 'Montserrat',
                  fontWeight: FontWeight.w400,
                  fontSize: 12.0,
                  color: Colors.black,
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.fromLTRB(45.0, 0, 45.0, 0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [ 
                  Text(
                    'Mulai: ${startTime.hour.toString().padLeft(2,'0')}:${startTime.minute.toString().padLeft(2,'0')} WIB',
                    style: const TextStyle(
                      color: Colors.black,
                      fontFamily: 'Montserrat',
                      fontSize: 13.0,
                      fontWeight: FontWeight.w500
                    ),
                  ),
                  Text(
                    'Selesai: ${selectedHour.toString().padLeft(2,'0')}:${selectedMinute.toString().padLeft(2,'0')} WIB',
                    style: const TextStyle(
                      color: Colors.black,
                      fontFamily: 'Montserrat',
                      fontSize: 13.0,
                      fontWeight: FontWeight.w500
                    ),
                  ),
                ],
              ),
            ),
            const SizedBox(height: 2.0),
            const Divider(
              thickness: 0.5,
              color: Colors.black,
              indent: 45.0,
              endIndent: 45.0,
            ),
            const SizedBox(height: 10.0),
            Center(
              child: ElevatedButton(
                onPressed: () async{
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

                    
                    postSessionVisitTime(sessionVisitTime)
                    .then((_) {
                      logger.d('Berhasil post ke API');
                    })
                    .catchError((error) {
                      setState(() {
                        logger.d('Gagal post ke API: $error');
                      });
                    });

                  }
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
            const SizedBox(height: 10.0),
            Padding(
              padding: const EdgeInsets.only(bottom: 10.0),
              child: Center(
                child: errorMessage != null 
                  ? Text(
                      errorMessage!,
                      style: const TextStyle(
                        fontFamily: 'Montserrat',
                        fontSize: 12.0,
                        fontWeight: FontWeight.w400,
                        color: Colors.red
                      ),
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
                    fontSize: 12.0,
                    fontWeight: FontWeight.w400,
                    decoration: TextDecoration.underline,
                    color: Color.fromRGBO(141, 141, 141, 1),
                    decorationThickness: 0.2,
                  ),
                ),
              ),
            ),
          ]
        ),
      ),
    );
  }
}
