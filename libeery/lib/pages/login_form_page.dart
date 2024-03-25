import 'package:flutter/material.dart';

class LoginFormPage extends StatelessWidget {
  final Widget formWidget;

  const LoginFormPage({super.key, required this.formWidget});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        color: const Color(0xFF0097DA), // Set the background color here
        child: Center(
          child: SingleChildScrollView(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                const Image(
                  image: AssetImage('assets/images/libeery_logo.png'),
                  width: 150,
                ),
                const SizedBox(height: 10),
                Padding(
                  padding: const EdgeInsets.all(20.0),
                  child: Card(
                    shape: const RoundedRectangleBorder(
                      borderRadius: BorderRadius.all(
                        Radius.circular(15),
                      ),
                    ),
                    child: Padding(
                      padding: const EdgeInsets.all(20.0),
                      child: formWidget, // Display the provided form widget
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
