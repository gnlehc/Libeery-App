import 'package:flutter/material.dart';
import 'package:libeery/models/msuser_model.dart';
import 'package:libeery/models/mssession_model.dart';
import 'package:libeery/pages/books_page.dart';
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
  final String? userId;
  final String? username;
  final int selectedIndex;

  const HomePage({
    Key? key,
    required this.userId,
    required this.username,
    required this.selectedIndex,
  }) : super(key: key);

  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  late AllUserBookedSession booked = AllUserBookedSession();
  List<MsSession> sessions = [];
  bool isLoading = true;
  int _selectedIndex = 0;

  @override
  void initState() {
    super.initState();
    _selectedIndex = widget.selectedIndex;
    _loadData();
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
      e.toString();
    }
  }

  bool isValidSession(int sessionID) {
    return sessions.any((session) => session.sessionID == sessionID);
  }

  String getSessionTime(int sessionID) {
    final session = sessions.firstWhere(
      (session) => session.sessionID == sessionID,
      orElse: () => MsSession(
        sessionID: -1,
        startSession: DateTime.now(),
        endSession: DateTime.now(),
      ),
    );

    if (session.sessionID != -1) {
      return parseTime(session.startSession, session.endSession);
    } else {
      return 'Session not found';
    }
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
                      padding: const EdgeInsets.fromLTRB(Spacing.medium, 0, Spacing.medium, 0),
                      child: ConstrainedBox(
                        constraints: booked.data == null || booked.data!.isEmpty
                            ? const BoxConstraints()
                           : BoxConstraints(maxHeight: 250.0 * booked.data!.length),
                        child: isLoading
                            ? const Center(
                                child: SizedBox(
                                  width: 30.0,
                                  height: 30.0,
                                  child: CircularProgressIndicator(),
                                ),
                              )
                              : booked.data == null || booked.data!.isEmpty 
                              ?  const NoSessionBooked()
                                : SingleChildScrollView(
                                    child: Column(
                                      children: [
                                        for (var i in booked.data!)
                                          Column(
                                            children: [
                                              OngoingSession(
                                                loker: i.lokerID!,
                                                periode: getSessionTime(
                                                    i.sessionID!),
                                                startSession: sessions
                                                    .firstWhere((session) =>
                                                        session.sessionID ==
                                                        i.sessionID)
                                                    .startSession,
                                              ),
                                              const SizedBox(height: Spacing.small),
                                            ],
                                          ),
                                      ],
                                    ),
                                  )
                                
                      ),
                    ),
                    const SizedBox(height: Spacing.medium),
                    const AddNewBookCard(),
                  ],
                ),
              ],
            ),
            Padding(
              padding: const EdgeInsets.fromLTRB(Spacing.large, Spacing.large, Spacing.large, 0),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: <Widget>[
                  Row(
                    children: [
                      const Expanded(
                        child: Text(
                          "Acara",
                          style: TextStyle(
                              fontWeight: FontWeights.bold, fontSize: FontSizes.title, color: AppColors.black),
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