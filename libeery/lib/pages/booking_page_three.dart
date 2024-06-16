import 'package:flutter/material.dart';
import 'package:libeery/arguments/user_argument.dart';
import 'package:libeery/models/msloker_model.dart';
import 'package:libeery/services/msloker_service.dart';
import 'package:libeery/pages/booking_page_four.dart';

class Loker {
  bool dipilih;
  Color color;

  Loker({required this.dipilih, required this.color});
}

class BookingPage3 extends StatefulWidget {
  final Widget previousPage;
  final List<int> sessionIds;
  final DateTime? startSession;
  final DateTime? endSession;
  final String userId;
  final String username;

  const BookingPage3(
      {Key? key,
      required this.previousPage,
      required this.startSession,
      required this.endSession,
      required this.sessionIds,
      required this.userId,
      required this.username})
      : super(key: key);

  @override
  BookingPage3State createState() => BookingPage3State();
}

class BookingPage3State extends State<BookingPage3> {
  GetAllMsLokerData listLoker = GetAllMsLokerData();
  List<bool> progressStatus = [false, false, true, false];
  bool isLoading = true;

  void getLoker() async {
    LokerService lokerService = LokerService();
    try {
      final lokerData = await lokerService.getLoker();
      setState(() {
        listLoker = lokerData;
        isLoading = false;
      });
    } catch (e) {
      setState(() {
        isLoading = false;
      });
      e.toString();
    }
  }

  // void getUserID() async {
  //   SharedPreferences prefs = await SharedPreferences.getInstance();
  //   setState(() {
  //     userID = prefs.getString('userID') ?? '';
  //   });
  // }

  @override
  void initState() {
    super.initState();
    getLoker();
    // final UserArguments args = ModalRoute.of(context)!.settings.arguments as UserArguments;
    // final String userId = args.userId;
  }

  // @override
  // void didChangeDependencies() {
  //   super.didChangeDependencies();
  //   if (!_initialized) {
  //     final UserArguments args = ModalRoute.of(context)!.settings.arguments as UserArguments;
  //     final String userId = args.userId;
  //     _initialized = true;
  //   }
  // }

  List<List<Loker>> lokerUser = List.generate(
    5,
    (index) => List.generate(
      5 * 12,
      (index) => Loker(dipilih: false, color: const Color(0xff5EC762)),
    ),
  );

  bool lokerDipilih = false;
  bool levelDipilih = false;
  int selectedColumn = -1;
  int selectedRow = -1;

  void updateSelectedLocker(int rowIndex, int columnIndex) {
    setState(() {
      // Check locker's availability
      final MsLoker? selectedLoker = listLoker.data?.firstWhere(
        (element) =>
            element.rowNumber == rowIndex + 1 &&
            element.columnNumber == columnIndex + 1,
        orElse: () => MsLoker(
            lockerID: 0,
            rowNumber: 0,
            columnNumber: 0,
            availability: 'Active',
            stsrc: ''),
      );

      // if booked, return because the color already set to be red
      if (selectedLoker == null || selectedLoker.availability == 'Booked') {
        return;
      }

      // Reselect to other locker
      if (selectedRow == rowIndex && selectedColumn == columnIndex) {
        lokerUser[rowIndex][columnIndex].dipilih = false;
        lokerUser[rowIndex][columnIndex].color =
            const Color(0xff5EC762); // Available color
        selectedRow = -1;
        selectedColumn = -1;
      } else {
        // Deselect locker
        if (selectedRow != -1 && selectedColumn != -1) {
          lokerUser[selectedRow][selectedColumn].dipilih = false;
          lokerUser[selectedRow][selectedColumn].color =
              const Color(0xff5EC762); // Available color
        }

        // Selecting any locker available
        lokerUser[rowIndex][columnIndex].dipilih = true;
        lokerUser[rowIndex][columnIndex].color =
            const Color(0xff0097DA); // Selected color
        selectedRow = rowIndex;
        selectedColumn = columnIndex;
      }
    });
  }

  Widget buildProgressIndicator(int step) {
    // Memeriksa apakah kotak progresif harus diisi atau tidak
    bool filled = progressStatus[step - 1];
    // Warna kotak progresif berdasarkan status
    Color color = filled
        ? const Color.fromRGBO(241, 135, 0, 1)
        : const Color.fromRGBO(197, 197, 197, 1);
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
    // final UserArguments args =
    //           ModalRoute.of(context)!.settings.arguments as UserArguments;
    // final String userId = args.userId;
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
              ],
            ),
          ),
        ),
        body: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Container(
                height: 120,
                padding: const EdgeInsets.symmetric(horizontal: 40),
                child: const Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      "Pilih Lokermu!",
                      style: TextStyle(
                        fontSize: 25,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                    Text(
                      "Pilih loker yang ingin kamu tempati selama mengunjungi LKC Binus. Angka 1 - 5 menunjukkan letak baris loker, dimana 1 berarti baris teratas dan 5 adalah baris terbawah.",
                      style: TextStyle(
                        fontSize: 12,
                        fontWeight: FontWeight.w400,
                      ),
                    ),
                  ],
                ),
              ),
              Container(
                height: 30,
                padding: const EdgeInsets.symmetric(horizontal: 40),
                child: const Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    AvailabilityInfo(
                      information: "Tersedia",
                      colorInfo: Color(0xff5EC762),
                    ),
                    AvailabilityInfo(
                      information: "Tidak Tersedia",
                      colorInfo: Color(0xffC75E5E),
                    ),
                    AvailabilityInfo(
                      information: "Pilihanmu",
                      colorInfo: Color(0xff0097DA),
                    ),
                  ],
                ),
              ),
              SizedBox(
                height: 300,
                child: Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 40),
                    child: Row(
                      children: [
                        const SizedBox(
                            height: 320,
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                              children: [
                                RowInfo(text: "1"),
                                RowInfo(text: "2"),
                                RowInfo(text: "3"),
                                RowInfo(text: "4"),
                                RowInfo(text: "5")
                              ],
                            )),
                        Expanded(
                          child: ListView.builder(
                            scrollDirection: Axis.horizontal,
                            itemCount: 60,
                            itemBuilder: (context, columnIndex) {
                              return Column(
                                children: List.generate(5, (rowIndex) {
                                  MsLoker? loker;
                                  if (listLoker.data != null) {
                                    loker = listLoker.data!.firstWhere(
                                      (element) =>
                                          element.rowNumber == rowIndex + 1 &&
                                          element.columnNumber ==
                                              columnIndex + 1,
                                      orElse: () => MsLoker(
                                          lockerID: 0,
                                          rowNumber: 0,
                                          columnNumber: 0,
                                          availability: 'Active',
                                          stsrc: ''),
                                    );
                                  }

                                  Color color;
                                  if (loker?.availability == 'Booked') {
                                    color = const Color(0xffC75E5E);
                                  } else {
                                    if (lokerUser[rowIndex][columnIndex]
                                        .dipilih) {
                                      color = const Color(0xff0097DA);
                                    } else {
                                      color = const Color(0xff5EC762);
                                    }
                                  }

                                  return GestureDetector(
                                      onTap: () {
                                        updateSelectedLocker(
                                            rowIndex, columnIndex);
                                      },
                                      child: Padding(
                                        padding: const EdgeInsets.only(
                                            top: 16.5, left: 10),
                                        child: Container(
                                          width: 40,
                                          height: 40,
                                          color: color,
                                        ),
                                      ));
                                }),
                              );
                            },
                          ),
                        ),
                      ],
                    )),
              ),
              Container(
                height: 60,
                padding:
                    const EdgeInsets.symmetric(vertical: 10, horizontal: 40),
                child: Column(children: [
                  Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        const Text("Loker yang dipilih"),
                        if (selectedRow != -1 && selectedColumn != -1)
                          Text(
                            listLoker.data!
                                .firstWhere((loker) =>
                                    loker.rowNumber == selectedRow + 1 &&
                                    loker.columnNumber == selectedColumn + 1)
                                .lockerID
                                .toString(),
                            style: const TextStyle(fontWeight: FontWeight.w700),
                          ),
                      ]),
                  const Divider(
                    thickness: 1.0,
                    color: Color(0xff333333),
                  )
                ]),
              ),
              Container(
                  height: 100,
                  padding: const EdgeInsets.symmetric(horizontal: 25),
                  child: Column(
                      mainAxisAlignment: MainAxisAlignment.spaceAround,
                      children: [
                        ElevatedButton(
                            onPressed: () {
                              if (selectedRow == -1 || selectedColumn == -1) {
                                ScaffoldMessenger.of(context).showSnackBar(
                                  const SnackBar(
                                    content: Text(
                                        'Silakan pilih sebuah loker terlebih dahulu.'),
                                  ),
                                );
                              } else {
                                DateTime? startSessionToSend =
                                    widget.startSession;
                                DateTime? endSessionToSend = widget.endSession;
                                // Check if startSession and endSession are null
                                if (widget.startSession == null ||
                                    widget.endSession == null) {
                                  startSessionToSend = null;
                                  endSessionToSend = null;
                                  Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                      builder: (context) => BookingPage4(
                                        username: widget.username,
                                        previousPage: widget.previousPage,
                                        startSession: startSessionToSend,
                                        endSession: endSessionToSend,
                                        sessionIds: widget.sessionIds,
                                        lockerID: listLoker.data!
                                            .firstWhere((loker) =>
                                                loker.rowNumber ==
                                                    selectedRow + 1 &&
                                                loker.columnNumber ==
                                                    selectedColumn + 1)
                                            .lockerID,
                                        userId: widget.userId,
                                      ),
                                      settings: RouteSettings(
                                        arguments:
                                            UserArguments(widget.userId, ''),
                                      ),
                                    ),
                                  );
                                } else if (widget.sessionIds.isEmpty) {
                                  Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                      builder: (context) => BookingPage4(
                                        username: widget.username,
                                        previousPage: widget.previousPage,
                                        startSession: widget.startSession,
                                        endSession: widget.endSession,
                                        sessionIds: const [],
                                        lockerID: listLoker.data!
                                            .firstWhere((loker) =>
                                                loker.rowNumber ==
                                                    selectedRow + 1 &&
                                                loker.columnNumber ==
                                                    selectedColumn + 1)
                                            .lockerID,
                                        userId: widget.userId,
                                      ),
                                      settings: RouteSettings(
                                        arguments:
                                            UserArguments(widget.userId, ''),
                                      ),
                                    ),
                                  );
                                }
                              }
                            },
                            style: ElevatedButton.styleFrom(
                              backgroundColor: const Color(0xffF18700),
                              fixedSize: const Size(134, 20),
                            ),
                            child: const Text("Selanjutnya",
                                style: TextStyle(color: Color(0xffF1F1F1)))),
                        TextButton(
                            onPressed: () {
                              Navigator.pop(context);
                            },
                            child: const Text("Sebelumnya...",
                                style: TextStyle(
                                  fontSize: 12.0,
                                  fontWeight: FontWeight.w400,
                                  decoration: TextDecoration.underline,
                                  color: Color.fromRGBO(141, 141, 141, 1),
                                  decorationThickness: 0.2,
                                )))
                      ])),
            ],
          ),
        ));
  }
}

class RowInfo extends StatelessWidget {
  const RowInfo({
    super.key,
    required this.text,
  });

  final String text;

  @override
  Widget build(BuildContext context) {
    return Text(text,
        style: const TextStyle(
          fontSize: 18,
          fontWeight: FontWeight.w500,
          color: Color(0xff333333),
        ));
  }
}

class AvailabilityInfo extends StatelessWidget {
  const AvailabilityInfo({
    super.key,
    required this.information,
    required this.colorInfo,
  });

  final Color colorInfo;
  final String information;

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Container(
          width: 15,
          height: 15,
          decoration: BoxDecoration(
            color: colorInfo,
            borderRadius: BorderRadius.circular(3),
          ),
        ),
        const SizedBox(width: 5),
        Text(
          information,
          style: TextStyle(
            fontSize: 14,
            fontWeight: FontWeight.w500,
            color: colorInfo,
          ),
        ),
      ],
    );
  }
}
