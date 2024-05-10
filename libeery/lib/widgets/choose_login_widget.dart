import 'dart:core';
import 'package:flutter/material.dart';
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
              fontSize: 16,
              fontWeight: FontWeight.w600,
              color: Color(0xFF333333)),
        ),
        const SizedBox(height: 8),
        const Text(
          "Masuk ke dalam akun BINUSmu terlebih dahulu yuk. Kamu seorang mahasiswa atau dosen atau staff nih?",
          style: TextStyle(
            fontSize: 12,
            fontWeight: FontWeight.w400,
            color: Color(0xFF333333),
          ),
          textAlign: TextAlign.center,
        ),
        const SizedBox(height: 16),
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
        const SizedBox(height: 16),
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
        const SizedBox(height: 24),
        ElevatedButton(
          onPressed: () => _navigateToLogin(context),
          style: ElevatedButton.styleFrom(
            backgroundColor: const Color(0xFFF18700), // Button color
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(20), // Button corner radius
            ),
            padding:
                const EdgeInsets.only(left: 16, right: 16), // Button padding
          ),
          child: const Text('Pilih', style: TextStyle(color: Colors.white)),
        )
      ],
    );
  }

  @override
  void dispose() {
    super.dispose();
  }
}
