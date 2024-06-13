import 'package:flutter/material.dart';

class CheckOutSuccessPopUp extends StatelessWidget {
  const CheckOutSuccessPopUp({super.key});

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(15.0),
      ),
      backgroundColor: Colors.white,
      contentPadding: const EdgeInsets.all(15.0),
      content: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Align(
            alignment: Alignment.topRight,
            child: IconButton(
              icon: const Icon(Icons.close),
              onPressed: () {
                Navigator.of(context).pop();
              },
            ),
          ),
          Image.asset(
            'assets/images/check-in-success.png',
            height: 100,
            width: 200,
            fit: BoxFit.contain,
          ),
          const SizedBox(height: 14),
          const Text(
            'Check-Out Berhasil!',
            style: TextStyle(
              fontSize: 18,
              fontWeight: FontWeight.bold,
            ),
          ),
          const SizedBox(height: 6),
          const Padding(
            padding: EdgeInsets.only(left: 12.0, right: 12.0),
            child: Text(
              'Jangan lupa untuk mengembalikan kunci loker!',
              style: TextStyle(fontSize: 14.0),
              textAlign: TextAlign.center,
            ),
          ),
          const SizedBox(height: 20),
        ],
      ),
    );
  }
}
