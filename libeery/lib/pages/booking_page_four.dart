import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:libeery/pages/home_page.dart';
import 'package:libeery/models/mssession_model.dart';
import 'package:libeery/services/mssession_service.dart';
import 'package:libeery/styles/style.dart';

class GroupedTimeSlot {
  final DateTime startTime;
  final DateTime endTime;
  int sessions;

  GroupedTimeSlot({
    required this.startTime,
    required this.endTime,
    required this.sessions,
  });
}

List<GroupedTimeSlot> groupSelectedSlots(
    List<DateTime> startSessions, List<DateTime> endSessions) {
  List<GroupedTimeSlot> groupedSlots = [];

  for (int i = 0; i < startSessions.length; i++) {
    var startTime = startSessions[i];
    var endTime = endSessions[i];

    if (groupedSlots.isNotEmpty) {
      var lastSlot = groupedSlots.last;
      if (lastSlot.endTime == startTime) {
        lastSlot = GroupedTimeSlot(
          startTime: lastSlot.startTime,
          endTime: endTime,
          sessions: lastSlot.sessions + 1,
        );
        groupedSlots.removeLast();
        groupedSlots.add(lastSlot);
        continue;
      }
    }

    groupedSlots.add(GroupedTimeSlot(
      startTime: startTime,
      endTime: endTime,
      sessions: 1,
    ));
  }

  return groupedSlots;
}

class BookingPage4 extends StatefulWidget {
  final List<int> sessionIds;
  final int lockerID;
  final Widget previousPage;
  final String userId;
  final DateTime? startSession;
  final DateTime? endSession;
  final String username;
  final String stsrc;

  const BookingPage4(
      {Key? key,
      required this.previousPage,
      required this.sessionIds,
      required this.lockerID,
      required this.userId,
      required this.startSession,
      required this.endSession,
      required this.username,
      required this.stsrc})
      : super(key: key);

  @override
  _BookingPage4State createState() => _BookingPage4State();
}

class _BookingPage4State extends State<BookingPage4> {
  bool isLoading = false;
  List<bool> progressStatus = [false, false, false, true];
  late List<MsSession> sessions = [];
  List<DateTime> startSessions = [];
  List<DateTime> endSessions = [];
  // AllUserBookedSession? _userBookedSessions;

  @override
  void initState() {
    super.initState();
    fetchSessions();
  }

  Future<void> fetchSessions() async {
    try {
      sessions = await MsSessionService.getSessionfromAPI();
      List<MsSession> selectedSessions = [];
      for (int sessionId in widget.sessionIds) {
        MsSession selectedSession = sessions.firstWhere(
          (session) => session.sessionID == sessionId,
          orElse: () => MsSession(
              sessionID: 0,
              startSession: DateTime.now(),
              endSession: DateTime.now()),
        );
        selectedSessions.add(selectedSession);
      }

      selectedSessions.sort((a, b) => a.sessionID.compareTo(b.sessionID));

      startSessions.clear();
      endSessions.clear();

      for (int i = 0; i < selectedSessions.length; i++) {
        startSessions.add(selectedSessions[i].startSession);
        endSessions.add(selectedSessions[i].endSession);
      }

      setState(() {
        // Update UI after fetching and sorting sessions
      });
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Failed to fetch sessions: $e')),
      );
    }
  }

  Future<void> _confirmBookingForNow(
      String userId, DateTime startSession, DateTime endSession) async {
    setState(() {
      isLoading = true;
    });

    try {
      final formattedStartSession =
          DateFormat('yyyy-MM-ddTHH:mm:ss+07:00').format(startSession);
      final formattedEndSession =
          DateFormat('yyyy-MM-ddTHH:mm:ss+07:00').format(endSession);

      // final timezoneOffset = getTimeZoneOffset(startSession);

      final postSession = SessionForNowRequestDTO(
        userID: userId,
        startSession: formattedStartSession,
        endSession: formattedEndSession,
        lokerID: widget.lockerID,
      );

      String? responseMessage =
          await MsSessionService.postDatatoAPIForNow(postSession);

      if (responseMessage == null) {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text('Booking Successful')),
        );
        Navigator.pushReplacement(
          context,
          MaterialPageRoute(
            builder: (context) => HomePage(
              userId: userId,
              username: widget.username,
              selectedIndex: 0,
            ),
          ),
        );
      } else {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('Failed to book session: $responseMessage')),
        );
      }
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Failed to book session: $e')),
      );
    } finally {
      setState(() {
        isLoading = false;
      });
    }
  }

  Future<void> _confirmBookingForLater(String userId) async {
    setState(() {
      isLoading = true;
    });

    try {
      List<String?> responseMessages = [];
      for (int sessionId in widget.sessionIds) {
        final postSession = SessionRequestDTO(
          userID: userId,
          sessionID: sessionId,
          lokerID: widget.lockerID,
        );
        String? responseMessage =
            await MsSessionService.postDatatoAPI(postSession);
        responseMessages.add(responseMessage);
      }

      bool allSuccess = responseMessages.every((message) => message == null);

      if (allSuccess) {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text('Booking Successful')),
        );
        Navigator.pushReplacement(
          context,
          MaterialPageRoute(
            builder: (context) => HomePage(
              userId: userId,
              username: widget.username,
              selectedIndex: 0,
            ),
          ),
        );
      } else {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('Failed to book one or more sessions')),
        );
      }
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Failed to book session: $e')),
      );
    } finally {
      setState(() {
        isLoading = false;
      });
    }
  }

  void confirmBooking() {
    if (widget.sessionIds.isEmpty) {
      _confirmBookingForNow(
          widget.userId, widget.startSession!, widget.endSession!);
    } else if (widget.startSession == null || widget.endSession == null) {
      _confirmBookingForLater(widget.userId);
    } else {
      _confirmBookingForNow(
          widget.userId, widget.startSession!, widget.endSession!);
    }
  }

  Widget buildProgressIndicator(int step) {
    bool filled = progressStatus[step - 1];
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

  String formatTime(DateTime? dateTime, {bool isMultipleSessions = false}) {
    if (dateTime != null) {
      if (isMultipleSessions || widget.sessionIds.length > 1) {
        return DateFormat.Hm().format(dateTime);
      } else {
        return DateFormat.Hm().format(dateTime) + ' WIB';
      }
    }
    return '';
  }

  @override
  Widget build(BuildContext context) {
    // bool isMultipleSessions = widget.sessionIds.length > 1;
    List<GroupedTimeSlot> groupedSlots =
        groupSelectedSlots(startSessions, endSessions);

    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
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
      body: Center(
        child: isLoading
            ? const CircularProgressIndicator()
            : SingleChildScrollView(
                child: Container(
                  width: MediaQuery.of(context).size.width * 0.9,
                  padding: const EdgeInsets.all(Spacing.small),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: <Widget>[
                      const SizedBox(height: 20),
                      const Center(
                        child: Text(
                          'Konfirmasi Reservasi',
                          style: TextStyle(
                            fontFamily: 'Montserrat',
                            fontWeight: FontWeights.bold,
                            fontSize: FontSizes.title,
                            color: AppColors.black,
                          ),
                        ),
                      ),
                      const SizedBox(height: Spacing.small),
                      const Center(
                        child: Text(
                          'Kamu berada pada tahap akhir peminjaman loker. Pastikan informasi loker yang tertera di bawah ini sudah sesuai dengan pilihanmu.',
                          style: TextStyle(
                            fontFamily: 'Montserrat',
                            fontSize: FontSizes.description,
                            fontWeight: FontWeights.regular,
                            color: AppColors.black,
                          ),
                          textAlign: TextAlign.center,
                        ),
                      ),
                      const SizedBox(height: Spacing.medium),
                      Padding(
                        padding: const EdgeInsets.all(5.0),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            const Text(
                              'Loker yang dipilih ',
                              style: TextStyle(
                                  fontSize: FontSizes.medium,
                                  fontWeight: FontWeights.regular,
                                  color: AppColors.black),
                            ),
                            Text(
                              '${widget.lockerID}',
                              style: const TextStyle(
                                  fontSize: FontSizes.medium,
                                  fontWeight: FontWeights.medium,
                                  color: AppColors.black),
                            ),
                          ],
                        ),
                      ),
                      const Divider(
                        thickness: 0.5,
                        color: AppColors.black,
                      ),
                      const Padding(
                        padding: EdgeInsets.all(5.0),
                        child: Text(
                          'Waktu Kunjungan',
                          textAlign: TextAlign.left,
                          style: TextStyle(
                              fontSize: FontSizes.medium,
                              fontWeight: FontWeights.regular,
                              color: AppColors.black),
                        ),
                      ),
                      if (widget.stsrc == "A") ...[
                        Padding(
                          padding: const EdgeInsets.all(5.0),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Text(
                                'Mulai ${formatTime(widget.startSession)}',
                                style: const TextStyle(
                                    fontSize: FontSizes.medium,
                                    fontWeight: FontWeights.medium,
                                    color: AppColors.black),
                                textAlign: TextAlign.center,
                              ),
                              Text(
                                'Selesai ${formatTime(widget.endSession)}',
                                style: const TextStyle(
                                    fontSize: FontSizes.medium,
                                    fontWeight: FontWeights.medium,
                                    color: AppColors.black),
                                textAlign: TextAlign.center,
                              )
                            ],
                          ),
                        )
                      ] else ...[
                        ListView.builder(
                          shrinkWrap: true,
                          physics: const NeverScrollableScrollPhysics(),
                          itemCount: groupedSlots.length,
                          itemBuilder: (context, index) {
                            GroupedTimeSlot slot = groupedSlots[index];
                            return Padding(
                              padding: const EdgeInsets.all(5.0),
                              child: Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  Text(
                                    '${DateFormat.Hm().format(slot.startTime)} - ${DateFormat.Hm().format(slot.endTime)} WIB',
                                    style: const TextStyle(
                                        fontSize: FontSizes.medium,
                                        fontWeight: FontWeights.medium,
                                        color: AppColors.black),
                                    textAlign: TextAlign.center,
                                  ),
                                  Text(
                                    '${slot.sessions} sesi',
                                    style: const TextStyle(
                                        fontSize: FontSizes.medium,
                                        fontWeight: FontWeights.medium,
                                        color: AppColors.black),
                                    textAlign: TextAlign.center,
                                  ),
                                ],
                              ),
                            );
                          },
                        )
                      ],
                      const Divider(
                        thickness: 0.5,
                        color: AppColors.black,
                      ),
                      const SizedBox(height: 20),
                      Center(
                        child: ElevatedButton(
                          onPressed: () => confirmBooking(),
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
                      const SizedBox(
                        height: Spacing.small,
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
      ),
    );
  }
}
