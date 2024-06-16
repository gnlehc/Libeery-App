import 'package:flutter/material.dart';
import 'package:libeery/styles/style.dart';

class NoSessionBooked extends StatelessWidget {
  const NoSessionBooked({super.key});

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Card(
        elevation: 2.0,
        child: Container(
          width: 350,
          height: 90,
          decoration: BoxDecoration(
            color: AppColors.lightGray,
            borderRadius: BorderRadius.circular(Spacing.small),
          ),
          child: const Padding(
            padding: EdgeInsets.all(Spacing.small),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Center(
                  child: Text(
                    'Belum Memesan Loker?',
                    style: TextStyle(
                        fontFamily: 'Montserrat',
                        fontSize: FontSizes.medium,
                        fontWeight: FontWeights.medium,
                        color: AppColors.black),
                  ),
                ),
                SizedBox(height: 2.0),
                Padding(
                  padding: EdgeInsets.symmetric(horizontal: Spacing.large),
                  child: Center(
                    child: Text(
                      'Yuk pesan loker dengan memencet tombol di bawah ini!',
                      style: TextStyle(
                          fontFamily: 'Montserrat',
                          fontSize: FontSizes.description,
                          fontWeight: FontWeights.regular,
                          color: AppColors.oldGray),
                      textAlign: TextAlign.center,
                    ),
                  ),
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
