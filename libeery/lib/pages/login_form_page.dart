import 'package:flutter/material.dart';
import 'package:libeery/styles/style.dart';

class LoginFormPage extends StatelessWidget {
  final Widget formWidget;

  const LoginFormPage({super.key, required this.formWidget});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        color: AppColors.blue,
        child: Center(
          child: SingleChildScrollView(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                const Image(
                  image: AssetImage('assets/images/libeery_logo.png'),
                  width: 150,
                ),
                const SizedBox(height: Spacing.small),
                Padding(
                  padding: const EdgeInsets.all(Spacing.medium),
                  child: Card(
                    shape: const RoundedRectangleBorder(
                      borderRadius: BorderRadius.all(
                        Radius.circular(15),
                      ),
                    ),
                    child: Padding(
                      padding: const EdgeInsets.all(Spacing.medium),
                      child: formWidget, 
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
