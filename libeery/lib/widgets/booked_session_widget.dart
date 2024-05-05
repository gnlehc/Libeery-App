import 'package:flutter/material.dart';

class OngoingSession extends StatelessWidget {
  final int loker;
  final String periode;
  const OngoingSession({super.key, required this.loker, required this.periode});

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        gradient: const LinearGradient(
          colors: [
            Color(0xFF0097DA), // Start color (blue)
            Color(0xFF0097DA), // Mid color (blue)
            Color.fromARGB(255, 148, 204, 228), // End Color
          ],
          begin: Alignment.topLeft, // Gradient start point
          end: Alignment.bottomRight, // Gradient end point
          stops: [0.0, 0.5, 1.0], // Gradient stops
          tileMode: TileMode.clamp, // Handle overflow
        ),
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
              const TextSpan(
                text: "Lokermu: ",
                style: TextStyle(fontSize: 16, fontFamily: "Montserrat"),
              ),
              TextSpan(
                text: '$loker',
                style: const TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 16,
                    fontFamily: "Montserrat"),
              )
            ])),
            RichText(
                text: TextSpan(children: [
              const TextSpan(
                text: "Periode: ",
                style: TextStyle(fontSize: 16, fontFamily: "Montserrat"),
              ),
              TextSpan(
                text: '$periode',
                style: const TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 16,
                    fontFamily: "Montserrat"),
              )
            ])),
          ],
        ),
      ),
    );
  }
}
