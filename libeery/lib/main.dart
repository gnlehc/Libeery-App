import 'package:flutter/material.dart';
import 'package:libeery/arguments/extract_argument.dart';
import 'package:libeery/pages/home_page.dart';
import 'package:libeery/pages/login_form_page.dart';
import 'package:libeery/pages/login_page.dart';
import 'package:libeery/pages/splashscreen_page.dart';
import 'package:libeery/widgets/login_mhs_form.dart';
import 'package:libeery/widgets/login_staff_form.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        fontFamily: 'Montserrat',
      ),
      initialRoute: '/',
      routes: {
        ExtractArgumentsScreen.routeName: (context) =>
            const ExtractArgumentsScreen(),
        '/': (context) => const SplashScreen(),
        '/chooselogin': (context) => const ChooseLoginPage(),
        '/loginstaff': (context) =>
            const LoginFormPage(formWidget: LoginStaffForm()),
        '/loginmahasiswa': (context) =>
            const LoginFormPage(formWidget: LoginMhsForm()),
        '/home': (context) {
          final String? userId =
              ModalRoute.of(context)?.settings.arguments as String?;
          return HomePage(userId: userId);
        },
      },
    );
  }
}
