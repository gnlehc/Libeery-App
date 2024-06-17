import 'package:flutter/material.dart';

class BookingIdProvider with ChangeNotifier {
  late String _bookingId;

  String get bookingId => _bookingId;

  set bookingId(String value) {
    _bookingId = value;
    notifyListeners();
  }
}
