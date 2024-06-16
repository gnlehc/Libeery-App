import 'package:flutter/material.dart';
import 'package:libeery/styles/style.dart';
import 'package:libeery/pages/booking_page_one.dart';

class AddNewBookCard extends StatefulWidget {
  final String userId;
  final String username;
  const AddNewBookCard(
      {super.key, required this.userId, required this.username});

  @override
  AddNewBookCardState createState() => AddNewBookCardState();
}

class AddNewBookCardState extends State<AddNewBookCard> {
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
        onTap: () {
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => BookingPageOne(
                username: widget.username,
                userId: widget.userId,
              ),
            ),
          );
        },
        child: Center(
          child: Container(
            width: 350,
            height: 50,
            decoration: BoxDecoration(
              gradient: const LinearGradient(
                colors: [
                  AppColors.orange,
                  Color.fromARGB(255, 250, 184, 97),
                  Color.fromARGB(255, 255, 203, 134),
                ],
                begin: Alignment.topLeft,
                end: Alignment.bottomRight,
                stops: [0.0, 0.7, 1.0],
                tileMode: TileMode.clamp,
              ),
              borderRadius: BorderRadius.circular(10),
            ),
            child: const Row(
              mainAxisSize: MainAxisSize.min,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                SizedBox(
                  width: 30,
                  height: 30,
                  child: Center(
                    child: Icon(
                      Icons.add,
                      size: FontSizes.subtitle,
                      color: AppColors.white,
                    ),
                  ),
                ),
                Text(
                  'Membuat Booking Loker',
                  style: TextStyle(
                    fontWeight: FontWeights.bold,
                    fontSize: 16,
                    color: AppColors.white,
                  ),
                ),
              ],
            ),
          ),
        ));
  }
}
