import 'dart:convert';
import 'dart:core';
import 'package:flutter/material.dart';
import 'package:dio/dio.dart';

class LoginStaffForm extends StatefulWidget {
  const LoginStaffForm({super.key});

  @override
  LoginStaffFormState createState() => LoginStaffFormState();
}

class LoginStaffFormState extends State<LoginStaffForm> {
  final TextEditingController nomorIndukController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();
  bool _isObscure = true;
  String? errorMessage;

  Future<String?> loginStaff(String nomorInduk, String password) async {
    try {
      final dio = Dio();
      dio.options.validateStatus = (status) {
        return true; // Always return true to prevent Dio from throwing exceptions
      };

      Map<String, dynamic> data = {
        'NIS': nomorInduk,
        'Password': password,
      };

      Response response = await dio.post(
        'https://libeery-api-production.up.railway.app/api/public/loginstaff',
        data: json.encode(data),
        options: Options(headers: {
          'Content-Type': 'application/json',
        }),
      );
      if (response.statusCode == 200) {
        // print('Login successful: ${response.data}');
        return null;
        // redirect to another page
      } else if (response.statusCode == 400) {
        return response.data['Message'];
      } else {
        return response.data['Message'] ?? 'Unknown error occurred.';
      }
    } catch (error) {
      return 'Unexpected error occurred: $error';
    }
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Align(
          alignment: Alignment.topLeft,
          child: IconButton(
            icon: const Icon(Icons.arrow_back),
            onPressed: () {
              Navigator.pop(context);
            },
          ),
        ),
        const Text(
          "Halo, Binusian!",
          style: TextStyle(
              fontSize: 16,
              fontWeight: FontWeight.w600,
              color: Color(0xFF333333)),
        ),
        const SizedBox(height: 8),
        const Text(
          "Sebelum masuk ke dalam LKC BINUS, harap memasukkan NIS dan kata sandi BinusMaya kamu ya!",
          style: TextStyle(
            fontSize: 12,
            fontWeight: FontWeight.w300,
            color: Color(0xFF333333),
          ),
          textAlign: TextAlign.center,
        ),
        const SizedBox(height: 12),
        Form(
          child: Column(
            children: <Widget>[
              Visibility(
                visible: errorMessage != null,
                child: Container(
                  width: double.infinity,
                  padding:
                      const EdgeInsets.symmetric(horizontal: 12, vertical: 10),
                  margin: const EdgeInsets.symmetric(vertical: 10),
                  decoration: BoxDecoration(
                    color: Colors.red[100],
                    borderRadius: BorderRadius.circular(10),
                    border: Border.all(color: Colors.red),
                  ),
                  child: Row(
                    children: [
                      const Icon(
                        Icons.error,
                        color: Colors.red,
                      ),
                      const SizedBox(width: 8),
                      Expanded(
                        child: Text(
                          errorMessage ?? '',
                          style: const TextStyle(
                            color: Colors.red,
                            fontSize: 11,
                            fontWeight: FontWeight.w400,
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
              const SizedBox(height: 10),
              const Align(
                alignment: Alignment.centerLeft,
                child: Text("NIS",
                    style: TextStyle(
                        fontSize: 14,
                        fontWeight: FontWeight.w600,
                        color: Color(0xFF333333))),
              ),
              const SizedBox(height: 10),
              TextFormField(
                controller: nomorIndukController,
                decoration: InputDecoration(
                  hintText: 'Masukkan NIS kamu...',
                  hintStyle: const TextStyle(
                    fontSize: 12,
                    fontWeight: FontWeight.w300,
                    color: Color(0xFF333333),
                  ),
                  border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(20.0),
                      borderSide: const BorderSide(
                          color: Color.fromARGB(0, 221, 221, 221))),
                  contentPadding: const EdgeInsets.all(10.0),
                  focusedBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(20.0),
                    borderSide: const BorderSide(
                      color: Color(
                          0xFF0097DA), // Set the border color when focused
                    ),
                  ),
                ),
              ),
              const SizedBox(height: 18),
              const Align(
                alignment: Alignment.centerLeft,
                child: Text("Password",
                    style: TextStyle(
                        fontSize: 14,
                        fontWeight: FontWeight.w600,
                        color: Color(0xFF333333))),
              ),
              const SizedBox(height: 10),
              TextFormField(
                controller: passwordController,
                obscureText: _isObscure,
                decoration: InputDecoration(
                  hintText: 'Masukkan password kamu...',
                  hintStyle: const TextStyle(
                    fontSize: 12,
                    fontWeight: FontWeight.w300,
                    color: Color(0xFF333333),
                  ),
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(20.0),
                    borderSide: const BorderSide(
                      color: Color.fromARGB(0, 221, 221, 221),
                    ),
                  ),
                  contentPadding: const EdgeInsets.all(10.0),
                  focusedBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(20.0),
                    borderSide: const BorderSide(
                      color: Color(0xFF0097DA),
                    ),
                  ),
                  suffixIcon: IconButton(
                    icon: Icon(
                      _isObscure ? Icons.visibility_off : Icons.visibility,
                      color: Colors.grey,
                    ),
                    onPressed: () {
                      setState(() {
                        _isObscure = !_isObscure;
                      });
                    },
                  ),
                ),
              ),
              const SizedBox(height: 24),
              ElevatedButton(
                onPressed: () async {
                  if (nomorIndukController.text == "" ||
                      passwordController.text == "") {
                    setState(() {
                      this.errorMessage =
                          "Harap mengisi kolom NIS dan Password";
                    });
                    return;
                  }

                  String? errorMessage = await loginStaff(
                    nomorIndukController.text,
                    passwordController.text,
                  );
                  if (errorMessage == null) {
                    // print("Success");
                  } else {
                    setState(() {
                      this.errorMessage = errorMessage;
                    });
                  }
                },
                style: ElevatedButton.styleFrom(
                  backgroundColor: const Color(0xFFF18700),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(20),
                  ),
                  padding: const EdgeInsets.only(left: 16, right: 16),
                ),
                child: const Text(
                  'Masuk',
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 14,
                    fontWeight: FontWeight.w500,
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
