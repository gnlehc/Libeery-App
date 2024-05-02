import 'package:flutter/material.dart';
import 'package:dotted_border/dotted_border.dart';

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
        child: Column(
          children: [
            Center(
              child: DottedBorder(
                dashPattern: const [10, 15],
                color: const Color(0xff333333),
                strokeWidth: 2,
                borderType: BorderType.RRect,
                radius: const Radius.circular(10),
                child: SizedBox(
                  width: 340,
                  height: 80,
                  child: Center(
                    child: DottedBorder(
                      dashPattern: const [10, 10],
                      color: const Color(0xff333333),
                      strokeWidth: 1.5,
                      borderType: BorderType.Circle,
                      child: Container(
                        width: 60,
                        height: 60,
                        decoration: const BoxDecoration(
                          shape: BoxShape.circle,
                        ),
                        child: const Center(
                          child: Icon(
                            Icons.add,
                            size: 40,
                            color: Color(0xff333333),
                          ),
                        ),
                      ),
                    ),
                  ),
                ),
              ),
            ),
          ],
        ));
  }
}
