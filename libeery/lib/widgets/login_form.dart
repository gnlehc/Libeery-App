import 'package:flutter/material.dart';

class LoginForm extends StatefulWidget {
  const LoginForm({Key? key}) : super(key: key);

  @override
  _LoginFormState createState() => _LoginFormState();
}

class _LoginFormState extends State<LoginForm> {
  final TextEditingController nomorIndukController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        const Text(
          "Halo, Pustakawan!",
          style: TextStyle(
              fontSize: 16,
              fontWeight: FontWeight.w600,
              color: Color(0xFF333333)),
        ),
        const SizedBox(height: 8),
        const Text(
          "Sebelum masuk ke dalam LKC BINUS, harap memasukkan NIM/NIS dan kata sandi BinusMaya kamu ya!",
          style: TextStyle(
            fontSize: 12,
            fontWeight: FontWeight.w300,
            color: Color(0xFF333333),
          ),
          textAlign: TextAlign.center,
        ),
        const SizedBox(height: 24),
        Form(
          child: Column(
            children: <Widget>[
              Align(
                alignment: Alignment.centerLeft,
                child: const Text("NIM/NIS",
                    style: TextStyle(
                        fontSize: 14,
                        fontWeight: FontWeight.w600,
                        color: Color(0xFF333333))),
              ),
              const SizedBox(height: 10),
              TextFormField(
                controller: nomorIndukController,
                decoration: InputDecoration(
                  hintText: 'Masukkan NIM/NIS kamu...',
                  hintStyle: TextStyle(
                    fontSize: 12,
                    fontWeight: FontWeight.w300,
                    color: Color(0xFF333333),
                  ),
                  border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(20.0),
                      borderSide:
                          BorderSide(color: Color.fromARGB(0, 221, 221, 221))),
                  contentPadding: EdgeInsets.all(10.0),
                  focusedBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(20.0),
                    borderSide: BorderSide(
                      color: Color(
                          0xFF0097DA), // Set the border color when focused
                    ),
                  ),
                ),
              ),
              const SizedBox(height: 18),
              Align(
                alignment: Alignment.centerLeft,
                child: const Text("Password",
                    style: TextStyle(
                        fontSize: 14,
                        fontWeight: FontWeight.w600,
                        color: Color(0xFF333333))),
              ),
              const SizedBox(height: 10),
              TextFormField(
                controller: passwordController,
                decoration: InputDecoration(
                  hintText: 'Masukkan password kamu...',
                  hintStyle: TextStyle(
                    fontSize: 12,
                    fontWeight: FontWeight.w300,
                    color: Color(0xFF333333),
                  ),
                  border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(20.0),
                      borderSide:
                          BorderSide(color: Color.fromARGB(0, 221, 221, 221))),
                  contentPadding: EdgeInsets.all(10.0),
                  focusedBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(20.0),
                    borderSide: BorderSide(
                      color: Color(
                          0xFF0097DA), // Set the border color when focused
                    ),
                  ),
                ),
              ),
              const SizedBox(height: 24),
              ElevatedButton(
                onPressed: () {
                  // Handle button press
                },
                child: Text(
                  'Masuk',
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 14,
                    fontWeight: FontWeight.w500,
                  ),
                ),
                style: ElevatedButton.styleFrom(
                  backgroundColor: Color(0xFFF18700), // Button color
                  shape: RoundedRectangleBorder(
                    borderRadius:
                        BorderRadius.circular(20), // Button corner radius
                  ),
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }

  @override
  void dispose() {
    // Clean up the controller when the widget is disposed.
    nomorIndukController.dispose();
    passwordController.dispose();
    super.dispose();
  }
}
