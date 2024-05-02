import 'package:flutter/material.dart';

class GreetUser extends StatelessWidget {
  final String? username;
  const GreetUser({super.key, this.username});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(left: 30, bottom: 10),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          const Text(
            "Selamat datang,",
            style: TextStyle(
                fontFamily: "Montserrat",
                color: Colors.white,
                fontSize: 20,
                fontWeight: FontWeight.w500),
          ),
          Text(
            '$username',
            style: const TextStyle(
                fontFamily: "Montserrat",
                color: Colors.white,
                fontSize: 35.0,
                fontWeight: FontWeight.bold),
          ),
        ],
      ),
    );
  }
}
