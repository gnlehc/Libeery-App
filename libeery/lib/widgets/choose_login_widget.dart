import 'dart:core';
import 'package:flutter/material.dart';
import 'package:libeery/styles/style.dart';
import 'package:libeery/widgets/login_options_button_widget.dart';

class ChooseLoginWidget extends StatefulWidget {
  const ChooseLoginWidget({super.key});

  @override
  ChooseLoginWidgetState createState() => ChooseLoginWidgetState();
}

class ChooseLoginWidgetState extends State<ChooseLoginWidget> {
  String _selectedButton = '';
  void _navigateToLogin(BuildContext context) {
    if (_selectedButton == 'Mahasiswa') {
      Navigator.pushNamed(context, '/loginmahasiswa');
    } else if (_selectedButton == 'Staff') {
      Navigator.pushNamed(context, '/loginstaff');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        const Text(
          "Halo, Binusian!",
          style: TextStyle(
              fontSize: FontSizes.subtitle,
              fontWeight: FontWeights.bold,
              color: AppColors.black
          ),
        ),
        const SizedBox(height: Spacing.small),
        const Text(
          "Masuk ke dalam akun BINUSmu terlebih dahulu yuk. Apakah kamu seorang mahasiswa atau dosen atau staff?",
          style: TextStyle(
            fontSize: FontSizes.description,
            fontWeight: FontWeights.regular,
            color: AppColors.black,
          ),
          textAlign: TextAlign.center,
        ),
        const SizedBox(height: Spacing.medium),
        LoginOptionsButton(
          buttonText: 'Mahasiswa',
          isSelected: _selectedButton == 'Mahasiswa',
          onPressed: (isSelected) {
            if (isSelected) {
              setState(() {
                _selectedButton = 'Mahasiswa';
              });
            }
          },
        ),
        const SizedBox(height: Spacing.medium),
        LoginOptionsButton(
          buttonText: 'Staff',
          isSelected: _selectedButton == 'Staff',
          onPressed: (isSelected) {
            if (isSelected) {
              setState(() {
                _selectedButton = 'Staff';
              });
            }
          },
        ),
        const SizedBox(height: Spacing.large),
        SizedBox(
          width: double.infinity, 
          child: ElevatedButton(
            onPressed: () => _navigateToLogin(context),
            style: ElevatedButton.styleFrom(
              backgroundColor: AppColors.orange, // Button color
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(10), // Button corner radius
              ),
              padding: const EdgeInsets.symmetric(horizontal: Spacing.small), // Button padding
            ),
            child: const Text('Pilih', style: TextStyle(color: Colors.white)),
          ),
        )
      ],
    );
  }

  @override
  void dispose() {
    super.dispose();
  }
}
