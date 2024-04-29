import 'package:flutter/material.dart';
import 'package:libeery/arguments/user_argument.dart';

class ExtractArgumentsScreen extends StatelessWidget {
  const ExtractArgumentsScreen({super.key});
  static const routeName = '/extractArguments';

  @override
  Widget build(BuildContext context) {
    final args = ModalRoute.of(context)!.settings.arguments as UserArguments;

    return Scaffold(
      appBar: AppBar(
        title: Text('User ID: ${args.userId}'),
      ),
      body: Center(
        child: Text('Username: ${args.username}'),
      ),
    );
  }
}
