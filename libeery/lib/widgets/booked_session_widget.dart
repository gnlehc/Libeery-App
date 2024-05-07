import 'package:flutter/material.dart';

class OngoingSession extends StatelessWidget {
  final int loker;
  final String periode;
  final DateTime startSession;
  const OngoingSession({super.key, required this.loker, required this.periode, required this.startSession});

  bool isSessionStart (DateTime now, DateTime startSession){
    int nowHour = now.hour;
    int sessionHour = startSession.hour;

    if(nowHour < sessionHour){
      return false;
    }else{
      return true;
    }
  }

  @override
  Widget build(BuildContext context) {
    final bool isSessionStarted = isSessionStart(DateTime.now(), startSession);
    return Container(
      decoration: BoxDecoration(
        color: isSessionStarted ? null : Color.fromARGB(255, 214, 214, 214),
        gradient: isSessionStarted
            ? const LinearGradient(
                colors: [
                  Color(0xFF0097DA),
                  Color(0xFF0097DA),
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
                    fontSize: 16, 
                    fontFamily: "Montserrat", 
                    color: isSessionStarted ? Colors.white : Colors.grey.shade600,
                  ),
                ),
                TextSpan(
                  text: '$loker',
                  style: TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 16,
                      fontFamily: "Montserrat",
                      color: isSessionStarted ? Colors.white : Colors.grey.shade600),
                )
            ])),
            RichText(
                text: TextSpan(children: [
              TextSpan(
                text: "Periode: ",
                style: TextStyle(fontSize: 16, fontFamily: "Montserrat", color: isSessionStarted ? Colors.white : Colors.grey.shade600),
              ),
              TextSpan(
                text: '$periode',
                style: TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 16,
                    fontFamily: "Montserrat", color: isSessionStarted ? Colors.white : Colors.grey.shade600),
              )
            ])),
          ],
        ),
      ),
    );
  }
}
