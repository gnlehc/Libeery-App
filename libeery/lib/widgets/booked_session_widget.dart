import 'package:flutter/material.dart';
import 'package:libeery/styles/style.dart';

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
                    color: isSessionStarted ? AppColors.white : AppColors.oldGray,
                  ),
                ),
                TextSpan(
                  text: '$loker',
                  style: TextStyle(
                      fontWeight: FontWeights.bold,
                      fontSize: FontSizes.subtitle,
                      fontFamily: "Montserrat",
                      color: isSessionStarted ? AppColors.white : AppColors.oldGray),
                )
            ])),
            RichText(
                text: TextSpan(children: [
              TextSpan(
                text: "Periode: ",
                style: TextStyle(fontSize: FontSizes.medium, fontFamily: "Montserrat", color: isSessionStarted ? AppColors.white : AppColors.oldGray),
              ),
              TextSpan(
                text: '$periode',
                style: TextStyle(
                    fontWeight: FontWeights.bold,
                    fontSize: FontSizes.subtitle,
                    fontFamily: "Montserrat", color: isSessionStarted ? AppColors.white : AppColors.oldGray),
              )
            ])),
          ],
        ),
      ),
    );
  }
}
