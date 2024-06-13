import 'package:flutter/material.dart';
import 'package:libeery/styles/style.dart';

class GreetUser extends StatelessWidget {
  final String? username;
  const GreetUser({super.key, this.username});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(left: Spacing.large, bottom: Spacing.medium),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          const Text(
            "Selamat datang,",
            style: TextStyle(
                fontFamily: "Montserrat",
                color: AppColors.white,
                fontSize: FontSizes.subtitle,
                fontWeight: FontWeights.regular),
          ),
          Text(
            '$username',
            style: const TextStyle(
                fontFamily: "Montserrat",
                color: AppColors.white,
                fontSize: FontSizes.header,
                fontWeight: FontWeights.bold),
          ),
        ],
      ),
    );
  }
}
