import 'package:flutter/material.dart';

class GreetUser extends StatelessWidget {
  final String? username;
  const GreetUser({super.key, this.username});

  @override
  Widget build(BuildContext context) {
    return Container(
        color: const Color(0xff333333),
        height: 250,
        width: double.infinity,
        child: Padding(
          padding: const EdgeInsets.all(30),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const Text(
                "Selamat datang,",
                style: TextStyle(
                    color: Colors.white,
                    fontSize: 20,
                    fontWeight: FontWeight.w500),
              ),
              Text(
                '$username',
                style: const TextStyle(
                    color: Colors.white,
                    fontSize: 35.0,
                    fontWeight: FontWeight.bold),
              )
            ],
          ),
        ));
  }
}
