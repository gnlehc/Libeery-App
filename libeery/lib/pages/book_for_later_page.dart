import 'package:flutter/material.dart';
import 'package:libeery/models/mssession_model.dart';
import 'package:libeery/pages/booking_page_three.dart';
import 'package:libeery/services/mssession_service.dart';
import 'package:libeery/styles/style.dart';
import 'package:logger/logger.dart';

void main() => runApp(const MaterialApp(
      home: BookForLater(),
    ));

class GroupedTimeSlot {
  final DateTime startTime;
  final DateTime endTime;
  int sessions;

  GroupedTimeSlot(
      {required this.startTime, required this.endTime, required this.sessions});
}

List<GroupedTimeSlot> groupSelectedSlots(List<String> selectedSlots) {
  List<GroupedTimeSlot> groupedSlots = [];

  for (var slot in selectedSlots) {
    var parts = slot.split('-');
    var startTimeString = parts[0].trim();
    var endTimeString = parts[1].trim();

    var startTime = int.parse(startTimeString.split('.')[0]);
    var endTime = int.parse(endTimeString.split('.')[0]);
    var startTimeHour = DateTime(DateTime.now().year, DateTime.now().month,
        DateTime.now().day, startTime);
    var endTimeHour = DateTime(
        DateTime.now().year, DateTime.now().month, DateTime.now().day, endTime);

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

    groupedSlots.add(GroupedTimeSlot(
        startTime: startTimeHour, endTime: endTimeHour, sessions: 1));
  }

  return groupedSlots;
}

class BookForLater extends StatefulWidget {
  const BookForLater({super.key});

  @override
  State<BookForLater> createState() => _BookForLaterState();
}

class _BookForLaterState extends State<BookForLater> {
  List<bool> progressStatus = [false, true, false, false];
  List<MsSession>? sessions;

  late List<String> selectedSlots;
  late int? selectedSessionID;
  String? errorMessage;
  String? errorMessage2;

  final Logger logger = Logger(
    printer: PrettyPrinter(), // Printer untuk menata keluaran log
    level: Level.debug, // Level logging yang digunakan
  );



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

  @override
  void initState() {
    super.initState();
    selectedSlots = [];
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
      body: SingleChildScrollView(
        child: Container(
          color: Colors.white,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              const Padding(
                padding: EdgeInsets.fromLTRB(Spacing.large, Spacing.small, Spacing.large, 0),
                child: Text(
                  'Pilih Waktu Kunjunganmu!',
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
                  'Pastikan kamu memilih waktu yang benar untuk kunjungan. Tips: jika tidak memungkinkan untuk keluar LKC pada waktu yang ada, kamu dapat memilih 2 sesi berturut saja.',
                  style: TextStyle(
                    fontFamily: 'Montserrat',
                    fontWeight: FontWeights.regular,
                    color: AppColors.black,
                    fontSize: FontSizes.description,
                  ),
                  textAlign: TextAlign.justify,
                ),
              ),
              Padding(
                  padding: const EdgeInsets.fromLTRB(Spacing.large, Spacing.medium, Spacing.large, 0),
                  child: FutureBuilder<List<MsSession>>(
                      future: MsSessionService.getSessionfromAPI(),
                      builder:
                          (context, AsyncSnapshot<List<MsSession>> snapshot) {
                        if (snapshot.connectionState ==
                            ConnectionState.waiting) {
                          return const CircularProgressIndicator();
                        } else if (snapshot.hasError) {
                          return Text('Error: ${snapshot.error}');
                        } else {
                          sessions = snapshot.data;
                          if (sessions == null || sessions!.isEmpty) {
                            return const Text('No data available');
                          } else {
                            return ListView.builder(
                                shrinkWrap: true,
                                itemCount: sessions!.length,
                                itemBuilder: ((context, index) {
                                  final session = sessions![index];
                                  final startTime = session.startSession.hour;
                                  final endTime = session.endSession.hour;
                                  final startTimeFormatted = startTime.toString().padLeft(2, '0');
                                  final endTimeFormatted =endTime.toString().padLeft(2, '0');
                                  final rangetime ='$startTimeFormatted.00 - $endTimeFormatted.00';

                                  return SizedBox(
                                    width: 290,
                                    height: 42,
                                    child: PhysicalModel(
                                      color: Colors.transparent,
                                      borderRadius: BorderRadius.circular(15),
                                      shadowColor:
                                          const Color.fromRGBO(237, 237, 237, 1).withOpacity(0.1),
                                      elevation: 5,
                                      child: Container(
                                        margin: const EdgeInsets.all(1.0),
                                        decoration: BoxDecoration(
                                          color: Colors.white,
                                          border: Border.all(
                                            color: selectedSlots.contains(rangetime)? AppColors.blue : const Color.fromRGBO(194, 194, 194, 1).withOpacity(0.3),
                                          ),
                                          borderRadius:BorderRadius.circular(15),
                                        ),
                                        child: CheckboxListTile(
                                          contentPadding: EdgeInsets.zero,
                                          visualDensity: const VisualDensity( horizontal: -4.0, vertical: -4.0),
                                          title: Padding(
                                            padding: const EdgeInsets.only(
                                                left: Spacing.small),
                                            child: SizedBox(
                                              child: Text(
                                                rangetime,
                                                style: const TextStyle(
                                                  fontFamily: 'Montserrat',
                                                  fontSize: FontSizes.description,
                                                  fontWeight: FontWeights.medium,
                                                  color: AppColors.black,
                                                ),
                                              ),
                                            ),
                                          ),
                                          checkboxShape: RoundedRectangleBorder(
                                            borderRadius:
                                                BorderRadius.circular(15),
                                          ),
                                          checkColor: AppColors.blue,
                                          fillColor: MaterialStateProperty.all( Colors.transparent),
                                          side: MaterialStateBorderSide.resolveWith((states) {
                                            if (states.contains(
                                                MaterialState.selected)) {
                                              return const BorderSide(color: AppColors.blue);
                                            } else {
                                              return const BorderSide(color: AppColors.lightGray);
                                            }
                                          }),
                                          controlAffinity:ListTileControlAffinity.trailing,
                                          value: selectedSlots.contains(rangetime),
                                          onChanged: (value) {
                                            setState(() {
                                              final now = DateTime.now();
                                              final parts = rangetime.split('-');
                                              final startTime = int.parse(parts[0].trim().split('.')[0]);
                                              final endTime = int.parse(parts[1].trim().split('.')[0]);
                                              final endSessionTime = DateTime(
                                                now.year,
                                                now.month,
                                                now.day,
                                                endTime,
                                              );

                                              if (endSessionTime.isBefore(now)) {
                                                setState(() {
                                                  errorMessage2 = 'Session telah lewat';
                                                });
                                                return;
                                              }else{
                                                errorMessage = null;
                                              }
                                              if (value != null && value) {
                                                final newSlot ='$startTimeFormatted.00 - $endTimeFormatted.00';
                                                // Hapus waktu kunjungan sebelumnya jika ada
                                                selectedSlots.removeWhere((slot) {
                                                  final parts = slot.split('-');
                                                  final slotStartTime =
                                                      int.parse(parts[0].trim().split('.')[0]);
                                                  final slotEndTime = int.parse(parts[1].trim().split('.')[0]);
                                                  return slotStartTime == startTime && slotEndTime <= endTime;
                                                });

                                                selectedSlots.add(newSlot);
                                                if (sessions != null) {
                                                  MsSession selectedSession =sessions!.firstWhere(
                                                    (session) =>session.startSession.hour ==startTime &&session.endSession.hour == endTime,
                                                    orElse: () => MsSession(
                                                      sessionID: -1, // Provide default values for sessionID, startSession, and endSession
                                                      startSession:DateTime.now(),
                                                      endSession: DateTime.now(),
                                                    ), 
                                                  );

                                                  selectedSessionID = selectedSession.sessionID; // Perbarui selectedSessionID
                                                }
                                              } else {
                                                selectedSlots.remove('$startTimeFormatted.00 - $endTimeFormatted.00');
                                                selectedSessionID = null;
                                              }
                                              selectedSlots.sort((a, b) =>int.parse(a.split('.')[0]).compareTo(int.parse( b.split('.')[0])));
                                            });
                                          },
                                        ),
                                      ),
                                    ),
                                  );
                                }));
                          }
                        }
                      })),
              const SizedBox(height: Spacing.medium),
              const Padding(
                padding: EdgeInsets.only(left: Spacing.large),
                child: Text(
                  'Waktu Kunjungan',
                  style: TextStyle(
                      fontSize: FontSizes.description,
                      color: AppColors.black,
                      fontWeight: FontWeights.regular,
                      fontFamily: 'Montserrat'
                      ),
                ),
              ),
              Visibility(
                  visible: selectedSlots.isNotEmpty,
                  child: Container(
                    padding: const EdgeInsets.fromLTRB(Spacing.large, 5.0, Spacing.large, 0),
                    color: Colors.white,
                    child: Column(
                      children: [
                        Column(
                          children:
                              groupSelectedSlots(selectedSlots).map((group) {
                            return Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Expanded(
                                  child: Text(
                                      '${group.startTime.hour.toString().padLeft(2, '0')}.00 - ${group.endTime.hour.toString().padLeft(2, '0')}.00 WIB',
                                      style: const TextStyle(
                                          color: AppColors.black,
                                          fontFamily: 'Montserrat',
                                          fontSize: FontSizes.medium,
                                          fontWeight: FontWeights.medium),
                                      textAlign: TextAlign.left),
                                ),
                                Expanded(
                                  child: Text('${group.sessions} sesi',
                                      style: const TextStyle(
                                          color: AppColors.black,
                                          fontFamily: 'Montserrat',
                                          fontSize: FontSizes.medium,
                                          fontWeight: FontWeights.medium),
                                      textAlign: TextAlign.right),
                                )
                              ],
                            );
                          }).toList(),
                        )
                      ],
                    ),
                  )),
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
                    if (selectedSlots.isNotEmpty) {
                      // Periksa apakah ada slot waktu yang dipilih
                      if (selectedSessionID != null) {
                        final postSession = SessionRequestDTO(
                          userID: 'b93cc732-28b9-44b9-b0ca-cb24b1ec2c58',
                          sessionID: selectedSessionID!,
                          lokerID: 1,
                        );

                        final String? result =
                            await MsSessionService.postDatatoAPI(postSession);

                        logger.d('Selected SessionID: $selectedSessionID');
                        if (result == null) {
                          logger.d('Berhasil post ke API');
                          Navigator.push(
                            context,
                            MaterialPageRoute(builder: (context) => const BookingPage3(previousPage: BookForLater())),
                          );
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
                child: errorMessage2 != null 
                  ? Text(
                      errorMessage2!,
                      style: const TextStyle(
                        fontFamily: 'Montserrat',
                        fontSize: FontSizes.description,
                        fontWeight: FontWeights.regular,
                        color: AppColors.red
                      ),
                  )
                  : const SizedBox(),
              ),
            ),
              Padding(
                padding: const EdgeInsets.only(bottom: Spacing.small),
                child: Center(
                  child: GestureDetector(
                    onTap: () {
                      Navigator.pop(context);
                    },
                    child: const Text(
                      'Sebelumnya..',
                      style: TextStyle(
                        fontFamily: 'Montserrat',
                        fontSize: FontSizes.description,
                        fontWeight: FontWeights.regular,
                        decoration: TextDecoration.underline,
                        decorationThickness: 0.2,
                        color: AppColors.oldGray,
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
