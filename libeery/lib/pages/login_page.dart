import 'package:flutter/material.dart';
import 'package:libeery/styles/style.dart';
import 'package:libeery/widgets/choose_login_widget.dart';

class ChooseLoginPage extends StatelessWidget {
  const ChooseLoginPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        color: AppColors.blue,
        child: const Center(
            child: SingleChildScrollView(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              Image(
                image: AssetImage('assets/images/libeery_logo.png'),
                width: 150,
              ),
              SizedBox(height: Spacing.small),
              Padding(
                padding: EdgeInsets.all(Spacing.medium),
                child: Card(
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.all(
                      Radius.circular(15),
                    ),
                  ),
                  child: Padding(
                    padding: EdgeInsets.all(Spacing.medium),
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
