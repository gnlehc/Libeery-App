import 'package:flutter/material.dart';

class HomePage extends StatelessWidget {
  final String? userId;

  const HomePage({super.key, required this.userId});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Home'),
      ),
      body: Center(
        child: Text(
          'Hello $userId',
          style: const TextStyle(fontSize: 24),
        ),
      ),
    );
  }
}
