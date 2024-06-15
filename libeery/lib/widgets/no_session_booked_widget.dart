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
            borderRadius: BorderRadius.circular(10.0),
          ),
          child: const Padding(
            padding:  EdgeInsets.all(8.0),
            child:  Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Center(
                  child: Text('Belum Memesan Loker?',
                  style: TextStyle(
                    fontFamily: 'Montserrat',
                    fontSize: 14,
                    fontWeight: FontWeight.w600,
                    color: Color.fromARGB(255, 111, 110, 110)
                  ),
                  ),
                ),
                SizedBox(height: 2.0),
                Padding(
                  padding: EdgeInsets.symmetric(horizontal: 30),
                  child: Center(
                    child: Text('Yuk pesan loker dengan memencet tombol di bawah ini!',
                    style: TextStyle(
                      fontFamily: 'Montserrat',
                      fontSize: 12,
                      fontWeight: FontWeight.w500,
                      color: AppColors.oldGray
                    ),
                    textAlign: TextAlign.center,
                    ),
                  ),
                )
              ],
            ),
          ) ,  
        ),
      ),
    );
  }
}