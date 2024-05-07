import 'package:flutter/material.dart';

class AddNewBookCard extends StatefulWidget {
  const AddNewBookCard({super.key});

  @override
  AddNewBookCardState createState() => AddNewBookCardState();
}

class AddNewBookCardState extends State<AddNewBookCard> {
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
        onTap: () {
          Navigator.pushNamed(context, '/bookingone');
        },
        child: Center(
          child: Container(
            width: 350,
            height: 50,
            decoration: BoxDecoration(
              gradient: const LinearGradient(
                colors: [
                  Color(0xffFFAF49), 
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
                      size: 20,
                      color: Color(0xffFFFFFF),
                    ),
                  ),
                ),
                Text(
                  'Membuat Booking Loker',
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 16,
                    color: Color(0xffFFFFFF),
                  ),
                ),
              ],
            ),
          ),
        ));
  }
}
