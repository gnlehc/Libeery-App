import 'package:flutter/material.dart';

class GreetUser extends StatelessWidget {
  final String? username;
  const GreetUser({super.key, this.username});

  String _processUsername(String? username) {
    if (username == null || username.isEmpty) {
      return "";
    }
    List<String> nameParts = username.split(" ");
    if (nameParts.length > 2) {
      return "${nameParts[0]} ${nameParts[1]}";
    }
    return username;
  }

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
                fontSize: 18,
                fontWeight: FontWeight.w500),
          ),
          Text(
            _processUsername(username),
            style: const TextStyle(
                fontFamily: "Montserrat",
                color: Colors.white,
                fontSize: 28.0,
                fontWeight: FontWeight.bold),
          ),
        ],
      ),
    );
  }
}
