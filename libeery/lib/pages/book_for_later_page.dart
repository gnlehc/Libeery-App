
import 'package:flutter/material.dart';
import 'package:dio/dio.dart';
import 'dart:convert';
import 'package:logger/logger.dart';


void main() => runApp( const MaterialApp(
  home: BookForLater(),
));

class Session{
  final int sessionID;
  final DateTime startSession;
  final DateTime endSession;

  Session({
    required this.sessionID,
    required this.startSession,
    required this.endSession,
  });

  factory Session.fromJson(Map<String, dynamic> json){
    return Session(
      sessionID: json['SessionID'],
      startSession: DateTime.parse(json['StartSession']),
      endSession: DateTime.parse(json['EndSession']),
    );
  }

}

class SessionList{
  final List<Session> data;
  final String message;
  final int statusCode;

  SessionList({
    required this.data,
    required this.message,
    required this.statusCode,
  });

  factory SessionList.fromJson(Map<String, dynamic> json){
    List<Session> sessions = [];
    if(json['Data'] !=null){
      sessions = List<Session>.from(json['Data'].map((e) => Session.fromJson(e)));
    }

    return SessionList(
      data: sessions,
      message: json['BaseOutput']['Message'],
      statusCode: json['BaseOutput']['StatusCode'],
      );
  }
}

class GroupedTimeSlot {
  final DateTime startTime;
  final DateTime endTime;
  int sessions;

  GroupedTimeSlot({required this.startTime, required this.endTime, required this.sessions});
}

List<GroupedTimeSlot> groupSelectedSlots(List<String> selectedSlots) {
  List<GroupedTimeSlot> groupedSlots = [];

  for (var slot in selectedSlots) {

    var parts = slot.split('-');
    var startTimeString = parts[0].trim();
    var endTimeString = parts[1].trim();

    var startTime = int.parse(startTimeString.split('.')[0]);
    var endTime = int.parse(endTimeString.split('.')[0]);
    var startTimeHour = DateTime(DateTime.now().year, DateTime.now().month, DateTime.now().day, startTime);
    var endTimeHour = DateTime(DateTime.now().year, DateTime.now().month, DateTime.now().day, endTime);
    
    
    if (groupedSlots.isNotEmpty) {
      var lastSlot = groupedSlots.last;
      if (lastSlot.endTime == startTimeHour) {
        lastSlot = GroupedTimeSlot(
          startTime: lastSlot.startTime,
          endTime: endTimeHour, 
          sessions: lastSlot.sessions + 1, 
        );
        groupedSlots.removeLast(); 
        groupedSlots.add(lastSlot); 
        continue; 
      }
    }
    
    groupedSlots.add(GroupedTimeSlot(startTime: startTimeHour, endTime: endTimeHour, sessions: 1));

  }

  return groupedSlots;
}

class PostSession {
  final String userID;
  final int sessionID;
  final int lokerID;

  PostSession({
    required this.userID,
    required this.sessionID,
    required this.lokerID,
  });

  Map<String, dynamic> toJson(){
    return{
      'UserID' : userID,
      'SessionID': sessionID,
      'LokerID': lokerID,
    };
  }
}

class BookForLater extends StatefulWidget {
  const BookForLater({super.key});

  @override
  State<BookForLater> createState() => _BookForLaterState();
}

class _BookForLaterState extends State<BookForLater> {
  

  List<bool> progressStatus = [false, true, false, false];
  List<Session>? sessions;

  late List<String> selectedSlots;
  late int? selectedSessionID;
  late String? errorMessage;

  final Logger logger = Logger(
  printer: PrettyPrinter(), // Printer untuk menata keluaran log
  level: Level.debug, // Level logging yang digunakan
  );

  Color color1 = const Color.fromRGBO(51, 51, 51, 1);
  Color color2 = const Color.fromRGBO(217, 217, 217, 1);
  Color color3 = const Color.fromRGBO(241, 135, 0, 1);
  Color color4 = const Color.fromRGBO(197, 197, 197, 1);
  Color color5 = const Color.fromRGBO(0, 151, 218, 1);


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
  void initState(){
    super.initState();
    selectedSlots = [];
  }

  Future<List<Session>> getSessionfromAPI() async{
    const url = 'https://libeery-api-development.up.railway.app/api/private/sessions';

    try {
      final dio = Dio();
      final response = await dio.get(url);

      if (response.statusCode == 200) {
        final List<dynamic> responseData = response.data['Data'];
        List<Session> sessions = [];

        for (var sessionData in responseData) {
          sessions.add(Session.fromJson(sessionData));
        }

        return sessions;
      } else {
        throw Exception('Failed to load sessions: ${response.statusCode}');
      }
    } catch (e) {
      throw Exception('Failed to load sessions: $e');
    }

  }

  Future <String?> postDatatoAPI(PostSession postSession) async{
    const url = 'https://libeery-api-development.up.railway.app/api/private/bookSession';
    try{
      final dio = Dio();
      dio.options.validateStatus = (status){
        return true;
      };

      Response response = await dio.post(
        url,
        data: json.encode(postSession.toJson()),
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
      backgroundColor: Colors.white,
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
      body: SingleChildScrollView(
        child: Container(
          color: Colors.white,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget> [
              Padding(
                  padding: const EdgeInsets.fromLTRB(45.0, 20.0, 45.0, 5.0),
                  child: Text(
                    'Pilih Waktu Kunjunganmu!',
                    style: TextStyle(
                      fontFamily: 'Montserrat',
                      fontWeight: FontWeight.w600,
                      fontSize: 18.0,
                      color: color1,
                    ),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.fromLTRB(45.0, 2.0, 45.0, 0),
                  child: Text(
                    'Pastikan kamu memilih waktu yang benar untuk kunjungan. Tips: jika tidak memungkinkan untuk keluar LKC pada waktu yang ada, kamu dapat memilih 2 sesi berturut saja.',
                    style: TextStyle(
                      fontFamily: 'Montserrat',
                      fontWeight: FontWeight.w300,
                      color: color1,
                      fontSize: 11.0,
                    ),
                    textAlign: TextAlign.justify,
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.fromLTRB(45.0, 20.0, 45.0, 5.0),
                  child: FutureBuilder<List<Session>>(
                    future: getSessionfromAPI(),
                    builder: (context, AsyncSnapshot<List<Session>> snapshot){
                      if(snapshot.connectionState == ConnectionState.waiting){
                        return const CircularProgressIndicator();
                      }else if(snapshot.hasError){
                        return Text('Error: ${snapshot.error}');
                      }else{
                         sessions = snapshot.data;
                        if(sessions == null || sessions!.isEmpty){
                          return const Text('No data available');
                        }else{
                        return ListView.builder(
                          shrinkWrap: true,
                          itemCount: sessions!.length,
                          itemBuilder: ((context, index) {
                            final session = sessions![index];
                            final startTime = session.startSession.hour;
                            final endTime = session.endSession.hour;
                            final startTimeFormatted = startTime.toString().padLeft(2, '0');
                            final endTimeFormatted = endTime.toString().padLeft(2, '0');
                            final rangetime = '$startTimeFormatted.00 - $endTimeFormatted.00';

                            return SizedBox(
                              width: 290,
                              height: 42,
                              child: PhysicalModel(
                                color: Colors.transparent,
                                borderRadius:  BorderRadius.circular(17),
                                shadowColor: const Color.fromRGBO(237, 237, 237, 1).withOpacity(0.1),
                                elevation: 5, 
                                child: Container(
                                  margin: const EdgeInsets.all(1.0),
                                  decoration: BoxDecoration(
                                    color: Colors.white,
                                    border: Border.all(
                                      color: selectedSlots.contains(rangetime) ? color5 : const Color.fromRGBO(194, 194, 194, 1).withOpacity(0.3),
                                      ),
                                    borderRadius: BorderRadius.circular(17),
                                  ),
                                  child: CheckboxListTile(
                                    contentPadding: EdgeInsets.zero,
                                    visualDensity: const VisualDensity(horizontal: -4.0, vertical: -4.0),
                                    title: Padding(
                                      padding: const EdgeInsets.only(left:10.0),
                                      child: SizedBox(
                                        child: Text(
                                          rangetime,
                                          style: const TextStyle(
                                            fontFamily: 'Montserrat',
                                            fontSize: 10.0,
                                            fontWeight: FontWeight.w500,
                                            color: Colors.black,
                                            ),
                                          ),
                                        ),
                                      ),
                                      checkboxShape: RoundedRectangleBorder(
                                        borderRadius: BorderRadius.circular(20),
                                      ),
                                      checkColor: Colors.blue,
                                      fillColor: MaterialStateProperty.all(Colors.transparent),
                                      side: MaterialStateBorderSide.resolveWith((states){
                                        if(states.contains(MaterialState.selected)){
                                          return BorderSide(color:color5);
                                        }else{
                                          return BorderSide(color: color4);
                                        }
                                      }),
                                       controlAffinity: ListTileControlAffinity.trailing,
                                       value: selectedSlots.contains(rangetime),
                                       onChanged: (value){
                                        setState(() {
                                          if(value != null && value){
                                            
                                              final newSlot = '$startTimeFormatted.00 - $endTimeFormatted.00';
                                              // Hapus waktu kunjungan sebelumnya jika ada
                                              selectedSlots.removeWhere((slot) {
                                                final parts = slot.split('-');
                                                final slotStartTime = int.parse(parts[0].trim().split('.')[0]);
                                                final slotEndTime = int.parse(parts[1].trim().split('.')[0]);
                                                return slotStartTime == startTime && slotEndTime <= endTime;
                                                });
                                              
                                              selectedSlots.add(newSlot);
                                              if (sessions != null) {
                                              Session selectedSession = sessions!.firstWhere(
                                                (session) =>
                                                    session.startSession.hour == startTime &&
                                                    session.endSession.hour == endTime,
                                                orElse: () => Session(
                                                  sessionID: -1, // Provide default values for sessionID, startSession, and endSession
                                                  startSession: DateTime.now(),
                                                  endSession: DateTime.now(),
                                                ), // Return a default Session if no match is found
                                              );

                                              selectedSessionID = selectedSession.sessionID; // Perbarui selectedSessionID
        }
                                            } else {
                                              selectedSlots.remove('$startTimeFormatted.00 - $endTimeFormatted.00');
                                              selectedSessionID = null;
                                            }
                                            selectedSlots.sort((a,b)=> int.parse(a.split('.')[0]).compareTo(int.parse(b.split('.')[0])));
                                        });
                                      },
                                    ),
                                ),
                              ),
                            );
                          }
                        ));
                      }
                    }
                    }
                  )
                ),
                const SizedBox(height: 26.0),
                const Padding(
                  padding: EdgeInsets.only(left: 45.0),
                  child: Text(
                    'Waktu Kunjungan',
                    style: TextStyle(
                      fontSize: 12.0,
                      color: Colors.black,
                      fontWeight: FontWeight.w400,
                      fontFamily: 'Montserrat'
                    ),
                  ),
                ),
                Visibility(
                  visible: selectedSlots.isNotEmpty,
                  child: Container(
                    padding: const EdgeInsets.fromLTRB(45.0, 5.0, 45.0, 0),
                    color: Colors.white,
                    child: Column(
                      children: [
                        Column(
                          children: groupSelectedSlots(selectedSlots)
                            .map((group) {
                          return Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              const Padding(padding:EdgeInsets.all(2.0)),
                              Expanded(
                                child: Text(
                                  '${group.startTime.hour.toString().padLeft(2,'0')}.00 - ${group.endTime.hour.toString().padLeft(2,'0')}.00 WIB',
                                  style: const TextStyle(
                                    color: Colors.black,
                                    fontFamily: 'Montserrat',
                                    fontSize: 13.0,
                                    fontWeight: FontWeight.w500
                                  ),
                                  textAlign: TextAlign.left
                                ),
                              ),
                              Expanded(
                                child: Text(
                                  '${group.sessions} sesi',
                                  style: const TextStyle(
                                    color: Colors.black,
                                    fontFamily: 'Montserrat',
                                    fontSize: 13.0,
                                    fontWeight: FontWeight.w500
                                  ),
                                textAlign: TextAlign.right
                                ),
                              )
                            ],
                          );
                        }).toList(),
                        )
                      ],
                    ),
                  )
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
                      if (selectedSlots.isNotEmpty) { // Periksa apakah ada slot waktu yang dipilih
                          if (selectedSessionID != null) {
                            final postSession = PostSession(
                              userID: 'b93cc732-28b9-44b9-b0ca-cb24b1ec2c58',
                              sessionID: selectedSessionID!,
                              lokerID: 1,
                            );

                            final String? result = await postDatatoAPI(postSession);
                            
                            logger.d('Selected SessionID: $selectedSessionID');
                            if (result == null) {
                              logger.d('Berhasil post ke API');
                              // navigate ke page selanjutnya
                            } else {
                              setState(() {
                                logger.e('Gagal post ke API: $result');
                                errorMessage = result;
                              });
                            }
                          } else {
                            logger.d('No sessionID selected');
                            setState(() {
                              errorMessage = 'No sessionID selected';
                            });
                          }
                        } else {
                          logger.d('No session slot selected');
                          setState(() {
                            errorMessage = 'No session slot selected';
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
                  padding: const EdgeInsets.only(bottom: 20.0),
                  child: Center(
                    child: GestureDetector(
                      onTap: () {
                        Navigator.pop(context);
                      }, 
                      child: const Text(
                        'Sebelumnya..',
                        style: TextStyle(
                          fontFamily: 'Montserrat',
                          fontSize: 12.0,
                          fontWeight: FontWeight.w400,
                          decoration: TextDecoration.underline,
                          decorationThickness: 0.2,
                          color: Color.fromRGBO(141, 141, 141, 1),
                        ),
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

