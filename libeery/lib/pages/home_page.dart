import 'package:flutter/material.dart';
import 'package:libeery/models/msuser_model.dart';
import 'package:libeery/models/mssession_model.dart';
import 'package:libeery/services/msuser_service.dart';
import 'package:libeery/services/mssession_service.dart';
import 'package:libeery/widgets/book_session_widget.dart';
import 'package:libeery/widgets/booked_session_widget.dart';
import 'package:libeery/widgets/user_greetings_widget.dart';
import 'package:libeery/widgets/navbar_widget.dart';

class HomePage extends StatefulWidget {
  final String? userId;
  final String? username;
  
  const HomePage({Key? key, required this.userId, required this.username}) : super(key: key);

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
    return sessions.any((session) =>
        session.sessionID == sessionID);
  }

  String getSessionTime(int sessionID) {
    final session = sessions.firstWhere(
      (session) => session.sessionID == sessionID,
      orElse: () => MsSession(
        sessionID: -1,
        startSession: DateTime.now(),
        endSession: DateTime.now(),
      )
    );

    if (session.sessionID != -1) {
      return parseTime(session.startSession, session.endSession);
    } else {
      return 'Session not found';
    }
  }

  String parseTime(DateTime startTime, DateTime endTime) {
    final String formattedStartTime = '${startTime.hour.toString().padLeft(2, '0')}:${startTime.minute.toString().padLeft(2, '0')}';
    final String formattedEndTime = '${endTime.hour.toString().padLeft(2, '0')}:${endTime.minute.toString().padLeft(2, '0')}';

    return '$formattedStartTime - $formattedEndTime WIB';
  }

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
    if (_selectedIndex == 0) {
      Navigator.push(
        context,
        MaterialPageRoute(
          builder: (context) => HomePage(
            userId: widget.userId,
            username: widget.username,
          ),
        ),
      );
    } else if (_selectedIndex == 1) {
      // Navigate to Books Page
    } else if (_selectedIndex == 2) {
      // Navigate to Profile Page
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Stack(
            children: [
              Container(
                color: const Color(0xFF333333),
                height: 250,
              ),
              Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  const SizedBox(height: 100),
                  GreetUser(username: widget.username),
                  const SizedBox(height: 20),
                  Padding(
                    padding: const EdgeInsets.fromLTRB(20.0, 0, 20.0, 0),
                    child: ConstrainedBox(
                      constraints: const BoxConstraints(maxHeight: 250),
                      child: isLoading
                        ? const CircularProgressIndicator()
                        : booked.data != null
                          ? SingleChildScrollView(
                              child: Column(
                                children: [
                                  for (var i in booked.data!)
                                    Column(
                                      children: [
                                        OngoingSession(
                                          loker: i.lokerID!,
                                          periode: getSessionTime(i.sessionID!),
                                          startSession: sessions.firstWhere((session) => session.sessionID == i.sessionID).startSession,
                                        ),
                                      ],
                                    ),
                                ],
                              ),
                            )
                          : const Center(
                              child: Text('No data available'),
                            ),
                    ),
                  ),
                  const SizedBox(height: 20),
                  const AddNewBookCard(),
                ],
              ),
            ],
          ),
          const Padding(
            padding: EdgeInsets.all(22),
            child: Column(
              children: <Widget>[
                Text(
                  "Acara",
                  style: TextStyle(fontWeight: FontWeight.bold, fontSize: 24),
                ),
              ],
            ),
          )
        ],
      ),
      bottomNavigationBar: NavBar(
        selectedIndex: _selectedIndex,
        onItemTapped: _onItemTapped,
      ),
    );
  }
}
