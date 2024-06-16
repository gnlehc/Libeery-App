import 'package:flutter/material.dart';
import 'package:libeery/models/msuser_model.dart';
import 'package:libeery/models/mssession_model.dart';
import 'package:libeery/pages/books_page.dart';
import 'package:libeery/pages/check_in_page.dart';
import 'package:libeery/pages/check_out_page.dart';
import 'package:libeery/pages/profile_page.dart';
import 'package:libeery/services/msuser_service.dart';
import 'package:libeery/services/mssession_service.dart';
import 'package:libeery/styles/style.dart';
import 'package:libeery/widgets/acara_homepage_widget.dart';
import 'package:libeery/widgets/book_session_widget.dart';
import 'package:libeery/widgets/booked_session_widget.dart';
import 'package:libeery/widgets/check-out-success_popup.dart';
import 'package:libeery/widgets/check_in_success_popup.dart';
import 'package:libeery/widgets/no_session_booked_widget.dart';
import 'package:libeery/widgets/user_greetings_widget.dart';
import 'package:libeery/widgets/navbar_widget.dart';

class HomePage extends StatefulWidget {
  final String userId;
  final String? username;
  final int selectedIndex;
  final String? nim;

  const HomePage({
    Key? key,
    required this.userId,
    required this.username,
    required this.selectedIndex,
    this.nim,
  }) : super(key: key);

  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  late AllUserBookedSession booked = AllUserBookedSession();
  // late AllUserBookedSession booked;
  List<MsSession> sessions = [];
  bool isLoading = true;
  int _selectedIndex = 0;
  bool isSessionStarted = false;

  @override
  void initState() {
    super.initState();
    _selectedIndex = widget.selectedIndex;
    _loadData();
  }

  void _checkIn(BuildContext context) async {
    // Tampilkan dialog check-in
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return const CheckInScreen();
      },
    ).then((value) {
      // Jika check-in berhasil, perbarui state
      if (value != null && value) {
        setState(() {
          isSessionStarted = true;
        });
      }
    });
  }

  void _checkOut(BuildContext context) async {
    // Tampilkan dialog checkout
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return const CheckOutScreen();
      },
    ).then((value) {
      // Jika checkout berhasil, perbarui state
      if (value != null && value) {
        setState(() {
          isSessionStarted = false;
        });
      }
    });
  }

  Future<void> _loadData() async {
    try {
      booked = await MsUserService().usersBookedSessions(widget.userId);

      final loadedSessions = await MsSessionService.getSessionfromAPI();
      setState(() {
        sessions = loadedSessions;
        isLoading = false;
      });
    } catch (e) {
      print('Error loading data: $e');
      // Handle error loading data
    }
  }

  // bool isValidSession(int sessionID) {
  //   return sessions.any((session) => session.sessionID == sessionID);
  // }

  String getSessionTime(int sessionID) {
    MsSession session = MsSession(
      sessionID: -1,
      startSession: DateTime.now(),
      endSession: DateTime.now(),
    );

    for (var sess in sessions) {
      if (sess.sessionID == sessionID) {
        session = sess;
        break;
      }
    }

    return parseTime(session.startSession, session.endSession);
  }

  DateTime getSessionStartDateTime(int sessionID) {
    MsSession session = MsSession(
      sessionID: -1,
      startSession: DateTime.now(),
      endSession: DateTime.now(),
    );

    for (var sess in sessions) {
      if (sess.sessionID == sessionID) {
        session = sess;
        break;
      }
    }

    return session.startSession;
  }

  String parseTime(DateTime startTime, DateTime endTime) {
    final String formattedStartTime =
        '${startTime.hour.toString().padLeft(2, '0')}:${startTime.minute.toString().padLeft(2, '0')}';
    final String formattedEndTime =
        '${endTime.hour.toString().padLeft(2, '0')}:${endTime.minute.toString().padLeft(2, '0')}';

    return '$formattedStartTime - $formattedEndTime WIB';
  }

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
    if (_selectedIndex == 0) {
      // stay on this page
    } else if (_selectedIndex == 1) {
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(
          builder: (context) => BooksPage(
            userId: widget.userId,
            username: widget.username,
            selectedIndex: 1,
          ),
        ),
      );
    } else if (_selectedIndex == 2) {
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(
          builder: (context) => ProfilePage(
            selectedIndex: 2,
            userId: widget.userId,
          ),
        ),
      );
      // Navigate to Profile Page
    }
  }

  void _showCheckInSuccessDialog() {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return const CheckInSuccessPopUp();
      },
    );
  }

  void _showCheckOutSuccessDialog() {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return const CheckOutSuccessPopUp();
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Stack(
              children: [
                Container(
                  color: AppColors.black,
                  height: 250,
                ),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: [
                    const SizedBox(height: 100),
                    GreetUser(username: widget.username),
                    const SizedBox(height: 20),
                    Padding(
                      padding: const EdgeInsets.fromLTRB(
                          Spacing.medium, 0, Spacing.medium, 0),
                      child: ConstrainedBox(
                          constraints:
                              booked.data == null || booked.data!.isEmpty
                                  ? const BoxConstraints()
                                  : BoxConstraints(
                                      maxHeight: 250.0 * booked.data!.length),
                          child: isLoading
                              ? const Center(
                                  child: SizedBox(
                                    width: 30.0,
                                    height: 30.0,
                                    child: CircularProgressIndicator(),
                                  ),
                                )
                              : booked.data == null || booked.data!.isEmpty
                                  ? const NoSessionBooked()
                                  : SingleChildScrollView(
                                      child: Column(
                                        children: [
                                          for (var i in booked.data!)
                                            Column(
                                              children: [
                                                OngoingSession(
                                                  loker: i.lokerID!,
                                                  periode: getSessionTime(i
                                                          .sessionID ??
                                                      -1), // Handle null sessionID
                                                  startSession:
                                                      getSessionStartDateTime(
                                                          i.sessionID ?? -1),
                                                ),
                                                const SizedBox(
                                                    height: Spacing.small),
                                              ],
                                            ),
                                        ],
                                      ),
                                    )),
                    ),
                    const SizedBox(height: Spacing.medium),
                    AddNewBookCard(
                      username: widget.username!,
                      userId: widget.userId,
                    ),
                  ],
                ),
              ],
            ),
            Padding(
              padding: const EdgeInsets.fromLTRB(
                  Spacing.large, Spacing.large, Spacing.large, 0),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: <Widget>[
                  Row(
                    children: [
                      const Expanded(
                        child: Text(
                          "Acara",
                          style: TextStyle(
                              fontWeight: FontWeights.bold,
                              fontSize: FontSizes.title,
                              color: AppColors.black),
                        ),
                      ),
                      GestureDetector(
                        onTap: () {
                          Navigator.pushNamed(context, '/acara');
                        },
                        child: const Text(
                          "Lihat lebih lanjut..",
                          style: TextStyle(
                              fontWeight: FontWeights.regular,
                              fontSize: FontSizes.description,
                              color: AppColors.blue,
                              decoration: TextDecoration.underline),
                        ),
                      ),
                    ],
                  ),
                  const AcaraListHomePageWidget(),
                ],
              ),
            )
          ],
        ),
      ),
      bottomNavigationBar: NavBar(
        selectedIndex: _selectedIndex,
        onItemTapped: _onItemTapped,
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: _showCheckInSuccessDialog,
        child: const Icon(Icons.check),
      ),
    );
  }
}
