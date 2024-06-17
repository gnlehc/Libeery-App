import 'dart:core';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:libeery/arguments/user_argument.dart';
import 'package:libeery/models/msmhs_model.dart';
import 'package:libeery/services/msmhs_service.dart';
import 'package:libeery/styles/style.dart';

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
            fontSize: FontSizes.subtitle,
            fontWeight: FontWeights.bold,
            color: AppColors.black,
          ),
        ),
        const SizedBox(height: Spacing.small),
        const Text(
          "Sebelum masuk ke dalam LKC BINUS, harap memasukkan NIM dan kata sandi BinusMaya kamu ya!",
          style: TextStyle(
            fontSize: FontSizes.description,
            fontWeight: FontWeights.regular,
            color: AppColors.black,
          ),
          textAlign: TextAlign.center,
        ),
        const SizedBox(height: Spacing.small),
        Form(
          child: Column(
            children: <Widget>[
              Visibility(
                visible: errorMessage != null,
                child: Container(
                  width: double.infinity,
                  padding: const EdgeInsets.symmetric(
                      horizontal: Spacing.small, vertical: Spacing.small),
                  margin: const EdgeInsets.symmetric(vertical: Spacing.small),
                  decoration: BoxDecoration(
                    color: Colors.red[100],
                    borderRadius: BorderRadius.circular(10),
                    border: Border.all(color: AppColors.red),
                  ),
                  child: Row(
                    children: [
                      const Icon(
                        Icons.error,
                        color: AppColors.red,
                      ),
                      const SizedBox(width: Spacing.small),
                      Expanded(
                        child: Text(
                          errorMessage ?? '',
                          style: const TextStyle(
                            color: AppColors.red,
                            fontSize: FontSizes.description,
                            fontWeight: FontWeights.regular,
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
              const SizedBox(height: Spacing.small),
              const Align(
                alignment: Alignment.centerLeft,
                child: Text("NIM",
                    style: TextStyle(
                        fontSize: FontSizes.medium,
                        fontWeight: FontWeights.medium,
                        color: AppColors.black)),
              ),
              const SizedBox(height: Spacing.small),
              TextFormField(
                controller: nomorIndukController,
                decoration: InputDecoration(
                  hintText: 'Masukkan NIM kamu...',
                  hintStyle: const TextStyle(
                    fontSize: FontSizes.description,
                    fontWeight: FontWeights.regular,
                    color: AppColors.black,
                  ),
                  border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(10.0),
                      borderSide: const BorderSide(
                          color: Color.fromARGB(0, 221, 221, 221))),
                  contentPadding: const EdgeInsets.all(10.0),
                  focusedBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(10.0),
                    borderSide: const BorderSide(
                      color: AppColors.blue,
                    ),
                  ),
                ),
                onChanged: (_) {
                  setState(() {
                    errorMessage = null;
                  });
                },
              ),
              const SizedBox(height: Spacing.medium),
              const Align(
                alignment: Alignment.centerLeft,
                child: Text("Password",
                    style: TextStyle(
                        fontSize: FontSizes.medium,
                        fontWeight: FontWeights.medium,
                        color: AppColors.black)),
              ),
              const SizedBox(height: Spacing.small),
              TextFormField(
                controller: passwordController,
                obscureText: _isObscure,
                decoration: InputDecoration(
                  hintText: 'Masukkan password kamu...',
                  hintStyle: const TextStyle(
                    fontSize: FontSizes.description,
                    fontWeight: FontWeights.regular,
                    color: AppColors.black,
                  ),
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(10.0),
                    borderSide: const BorderSide(
                      color: Color.fromARGB(0, 221, 221, 221),
                    ),
                  ),
                  contentPadding: const EdgeInsets.all(10.0),
                  focusedBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(10.0),
                    borderSide: const BorderSide(
                      color: AppColors.blue,
                    ),
                  ),
                  suffixIcon: IconButton(
                    icon: Icon(
                      _isObscure ? Icons.visibility_off : Icons.visibility,
                      color: AppColors.gray,
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
              const SizedBox(height: Spacing.medium),
              SizedBox(
                width: double.infinity,
                child: ElevatedButton(
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
                          Navigator.of(context).pushNamedAndRemoveUntil(
                            '/home',
                            (Route<dynamic> route) => false,
                            arguments: UserArguments(
                                response.userId!, response.username!),
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
                    backgroundColor: AppColors.orange,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(10),
                    ),
                    padding: const EdgeInsets.only(
                        left: Spacing.medium, right: Spacing.medium),
                  ),
                  child: const Text(
                    'Masuk',
                    style: TextStyle(
                      color: AppColors.white,
                      fontSize: FontSizes.medium,
                      fontWeight: FontWeights.medium,
                    ),
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
