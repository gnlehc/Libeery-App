import 'package:flutter/material.dart';
import 'package:libeery/arguments/extract_argument.dart';
import 'package:libeery/arguments/user_argument.dart';
import 'package:libeery/pages/booking_page_one.dart';
import 'package:libeery/pages/home_page.dart';
import 'package:libeery/pages/login_form_page.dart';
import 'package:libeery/pages/login_page.dart';
import 'package:libeery/pages/splashscreen_page.dart';
import 'package:libeery/widgets/login_mhs_form_widget.dart';
import 'package:libeery/widgets/login_staff_form_widget.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Flutter Demo',
      theme: ThemeData(
        fontFamily: 'Montserrat',
      ),
      initialRoute: '/',
      routes: {
        ExtractArgumentsScreen.routeName: (context) =>
            const ExtractArgumentsScreen(),
        '/': (context) => const SplashScreen(),
        '/home': (context) {
          final UserArguments args =
              ModalRoute.of(context)!.settings.arguments as UserArguments;
          final String username = args.username;
          final String userId = args.userId;
          return HomePage(userId: userId, username: username);
        },
        '/chooselogin': (context) => const ChooseLoginPage(),
        '/loginstaff': (context) =>
            const LoginFormPage(formWidget: LoginStaffForm()),
        '/loginmahasiswa': (context) =>
            const LoginFormPage(formWidget: LoginMhsForm()),
        '/bookingone': (context) => const BookingPageOne(),
      },
    );
  }
}
