import 'package:flutter/material.dart';
import 'package:libeery/widgets/booking_page_three.dart';
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
  Widget build(BuildContext context){
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        fontFamily: 'Montserrat',
      ),
      initialRoute: '/',
      routes: {
        '/': (context) => const BookingPage3(),
          // '/chooselogin': (context) => const ChooseLoginPage(),
          // '/loginstaff': (context) =>
          //     const LoginFormPage(formWidget: LoginStaffForm()),
          // '/loginmahasiswa': (context) =>
          //     const LoginFormPage(formWidget: LoginMhsForm()),
      },
    );
  }
}
