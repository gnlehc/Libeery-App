import 'package:flutter/material.dart';
import 'package:libeery/widgets/book_session_widget.dart';
import 'package:libeery/widgets/user_greetings_widget.dart';

class HomePage extends StatelessWidget {
  final String? userId;
  final String? username;

  const HomePage({super.key, required this.userId, required this.username});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Column(
      children: [
        GreetUser(
          username: username,
        ),
        const AddNewBookCard(),
      ],
    )
        // body: Center(
        //   child: Text(
        //     'Hello $username',
        //     style: const TextStyle(fontSize: 24),
        //   ),
        // ),
        );
  }
}
