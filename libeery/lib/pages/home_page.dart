import 'package:flutter/material.dart';
import 'package:libeery/models/msuser_model.dart';
import 'package:libeery/services/msuser_service.dart';
import 'package:libeery/widgets/book_session_widget.dart';
import 'package:libeery/widgets/booked_session_widget.dart';
import 'package:libeery/widgets/user_greetings_widget.dart';

class HomePage extends StatefulWidget {
  final String? userId;
  final String? username;
  const HomePage({super.key, required this.userId, required this.username});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  late AllUserBookedSession booked = AllUserBookedSession();
  @override
  void initState() {
    super.initState();
    getBooked().then((value) => setState(() {}));
  }

  Future<void> getBooked() async {
    booked = await MsUserService().usersBookedSessions(widget.userId);
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
                Container(
                  height: 250,
                  padding: const EdgeInsets.all(20.0),
                  child: booked.data != null
                      ? SingleChildScrollView(
                          child: Column(
                            children: [
                              for (var i in booked.data!)
                                Column(
                                  children: [
                                    OngoingSession(
                                      loker: i.lokerID!,
                                      periode: i.sessionID!,
                                    ),
                                    const SizedBox(
                                      height: 10,
                                    )
                                  ],
                                ),
                            ],
                          ),
                        )
                      : const CircularProgressIndicator(),
                  // const OngoingSession(
                  //     loker: , periode: "09:00 - 10:00"),
                ),
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
            ))
      ],
    ));
  }
}
