import 'package:flutter/material.dart';
import 'package:libeery/pages/check_in_page.dart';
import 'package:libeery/pages/check_out_page.dart';
import 'package:libeery/styles/style.dart';

class OngoingSession extends StatefulWidget {
  final int loker;
  final String periode;
  final DateTime startSession;
  final String userID;
  final String bookingID;
  final VoidCallback onCheckIn;
  final VoidCallback onCheckOut;

  const OngoingSession({
    Key? key,
    required this.loker,
    required this.periode,
    required this.startSession,
    required this.userID,
    required this.bookingID,
    required this.onCheckIn,
    required this.onCheckOut,
  }) : super(key: key);

  @override
  _OngoingSessionState createState() => _OngoingSessionState();
}

class _OngoingSessionState extends State<OngoingSession> {
  bool isCheckedIn = false;

  bool isSessionStart(DateTime now, DateTime startSession) {
    int nowHour = now.hour;
    int sessionHour = startSession.hour;

    return nowHour >= sessionHour;
  }

  void _showCheckInPopup(BuildContext context) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return CheckInScreen(
          userID: widget.userID,
          bookingID: widget.bookingID,
          onCheckInSuccess: () {
            setState(() {
              isCheckedIn = true;
            });
            widget.onCheckIn();
          },
        );
      },
    );
  }

  void _showCheckOutPopup(BuildContext context) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return CheckOutScreen(
          userID: widget.userID,
          bookingID: widget.bookingID,
        );
      },
    ).then((value) {
      if (value != null && value) {
        setState(() {
          isCheckedIn = false;
        });
        widget.onCheckOut();
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    final bool isSessionStarted =
        isSessionStart(DateTime.now(), widget.startSession);

    return Container(
      decoration: BoxDecoration(
        color: isSessionStarted ? null : AppColors.lightGray,
        gradient: isSessionStarted
            ? const LinearGradient(
                colors: [
                  AppColors.blue,
                  AppColors.blue,
                  Color.fromARGB(255, 148, 204, 228),
                ],
                begin: Alignment.topLeft,
                end: Alignment.bottomRight,
                stops: [0.0, 0.5, 1.0],
                tileMode: TileMode.clamp,
              )
            : null,
        borderRadius: BorderRadius.circular(10),
      ),
      width: 350,
      height: 100,
      child: Padding(
        padding: const EdgeInsets.all(20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            RichText(
              text: TextSpan(children: [
                TextSpan(
                  text: "Lokermu: ",
                  style: TextStyle(
                    fontSize: FontSizes.medium,
                    fontFamily: "Montserrat",
                    color:
                        isSessionStarted ? AppColors.white : AppColors.oldGray,
                  ),
                ),
                TextSpan(
                  text: '${widget.loker}',
                  style: TextStyle(
                    fontWeight: FontWeights.bold,
                    fontSize: FontSizes.subtitle,
                    fontFamily: "Montserrat",
                    color:
                        isSessionStarted ? AppColors.white : AppColors.oldGray,
                  ),
                )
              ]),
            ),
            RichText(
              text: TextSpan(children: [
                TextSpan(
                  text: "Periode: ",
                  style: TextStyle(
                    fontSize: FontSizes.medium,
                    fontFamily: "Montserrat",
                    color:
                        isSessionStarted ? AppColors.white : AppColors.oldGray,
                  ),
                ),
                TextSpan(
                  text: '${widget.periode}',
                  style: TextStyle(
                    fontWeight: FontWeights.bold,
                    fontSize: FontSizes.subtitle,
                    fontFamily: "Montserrat",
                    color:
                        isSessionStarted ? AppColors.white : AppColors.oldGray,
                  ),
                )
              ]),
            ),
            if (isSessionStarted)
              GestureDetector(
                onTap: () {
                  if (isCheckedIn) {
                    _showCheckOutPopup(context);
                  } else {
                    _showCheckInPopup(context);
                  }
                },
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    Text(
                      isCheckedIn ? 'Akhiri Sesi' : 'Mulai Sesi',
                      style: const TextStyle(
                        color: Colors.white,
                        fontSize: 11,
                      ),
                    ),
                    const Icon(
                      Icons.chevron_right,
                      color: Colors.white,
                      size: 16,
                    ),
                  ],
                ),
              ),
          ],
        ),
      ),
    );
  }
}
