import 'package:flutter/material.dart';
import 'package:libeery/widgets/choose_login_widget.dart';

class ChooseLoginPage extends StatelessWidget {
  const ChooseLoginPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        color: const Color(0xFF0097DA), // Set the background color here
        child: const Center(
            child: SingleChildScrollView(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              Image(
                image: AssetImage('assets/images/libeery_logo.png'),
                width: 150,
              ),
              SizedBox(height: 10),
              Padding(
                padding: EdgeInsets.all(20.0),
                child: Card(
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.all(
                      Radius.circular(15),
                    ),
                  ),
                  child: Padding(
                    padding: EdgeInsets.all(20.0),
                    child: ChooseLoginWidget(),
                  ),
                ),
              ),
            ],
          ),
        )),
      ),
    );
  }
}
