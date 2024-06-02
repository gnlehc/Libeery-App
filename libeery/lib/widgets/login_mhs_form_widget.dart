import 'dart:core';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:libeery/arguments/user_argument.dart';
import 'package:libeery/models/msmhs_model.dart';
import 'package:libeery/services/msmhs_service.dart';

class LoginMhsForm extends StatefulWidget {
  const LoginMhsForm({super.key});

  @override
  LoginMhsFormState createState() => LoginMhsFormState();
}

class LoginMhsFormState extends State<LoginMhsForm> {
  final TextEditingController nomorIndukController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();
  bool _isObscure = true;
  String? errorMessage;
  MsMhsService mhsService = MsMhsService();

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
          "Sebelum masuk ke dalam LKC BINUS, harap memasukkan NIM dan kata sandi BinusMaya kamu ya!",
          style: TextStyle(
            fontSize: 12,
            fontWeight: FontWeight.w400,
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
                child: Text("NIM",
                    style: TextStyle(
                        fontSize: 14,
                        fontWeight: FontWeight.w600,
                        color: Color(0xFF333333))),
              ),
              const SizedBox(height: 10),
              TextFormField(
                controller: nomorIndukController,
                decoration: InputDecoration(
                  hintText: 'Masukkan NIM kamu...',
                  hintStyle: const TextStyle(
                    fontSize: 12,
                    fontWeight: FontWeight.w400,
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
                      color: Color(0xFF0097DA),
                    ),
                  ),
                ),
                onChanged: (_) {
                  setState(() {
                    errorMessage = null;
                  });
                },
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
                    fontWeight: FontWeight.w400,
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
                onChanged: (_) {
                  setState(() {
                    errorMessage = null;
                  });
                },
              ),
              const SizedBox(height: 24),
              ElevatedButton(
                onPressed: () async {
                  if (nomorIndukController.text.isNotEmpty &&
                      passwordController.text.isNotEmpty) {
                    try {
                      LoginMhsResponseDTO response =
                          await mhsService.loginMahasiswa(
                        nomorIndukController.text,
                        passwordController.text,
                      );

                      if (response.statusCode == 200) {
                        print('Login successful, navigating to home screen...');
                        Navigator.of(context).pushNamed(
                          '/home',
                          arguments: UserArguments(
                            response.userId!,
                            response.username!,
                          ),
                        );
                      } else {
                        print('Login failed: ${response.message}');
                        setState(() {
                          errorMessage = 'Login failed: ${response.message}';
                        });
                      }
                    } on DioException catch (e) {
                      throw e.message.toString();
                    }
                  } else {
                    // One or both fields are empty, show error message
                    setState(() {
                      errorMessage = "Harap mengisi kolom NIM dan Password";
                    });
                  }
                  return;
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
    nomorIndukController.dispose();
    passwordController.dispose();
    super.dispose();
  }

  Future<void> loginMhs(BuildContext context) async {
    try {
      MsMhsService mhsService = MsMhsService();
      print('Attempting login with NIM: ${nomorIndukController.text}');
      LoginMhsResponseDTO response = await mhsService.loginMahasiswa(
        nomorIndukController.text,
        passwordController.text,
      );

      print('Login response status code: ${response.statusCode}');
      if (response.statusCode == 200) {
        print('Login successful, navigating to home screen...');
        Navigator.of(context).pushNamed(
          '/home',
          arguments: UserArguments(response.userId!, response.username!),
        );
      } else {
        print('Login failed: ${response.message}');
        setState(() {
          errorMessage = response.message;
        });
      }
    } catch (error) {
      print('Unexpected error occurred: $error');
      setState(() {
        errorMessage = 'Unexpected error occurred: $error';
      });
    }
  }
}
