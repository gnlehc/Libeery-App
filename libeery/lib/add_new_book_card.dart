import 'package:flutter/material.dart';

void main(){
  runApp(const AddNewBookCard());
}

class AddNewBookCard extends StatefulWidget {
  const AddNewBookCard({super.key});

  @override
  _AddNewBookCardState createState() => _AddNewBookCardState();
}

class _AddNewBookCardState extends State<AddNewBookCard> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Add New Book'),
      ),
      body: const Center(
        child: Text(
          'Add New Book Form',
          style: TextStyle(fontSize: 20.0),
        ),
      ),
    );
  }
}