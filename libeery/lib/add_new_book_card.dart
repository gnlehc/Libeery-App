import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

void main(){
  runApp(AddNewBookCard());
}

class AddNewBookCard extends StatefulWidget {
  @override
  _AddNewBookCardState createState() => _AddNewBookCardState();
}

class _AddNewBookCardState extends State<AddNewBookCard> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Add New Book'),
      ),
      body: Center(
        child: Text(
          'Add New Book Form',
          style: TextStyle(fontSize: 20.0),
        ),
      ),
    );
  }
}