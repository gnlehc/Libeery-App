// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:convert';

import 'package:libeery/outputs/baseoutput_model.dart';

class MsUser {
  final String nim;
  final String mhsName;

  MsUser({required this.nim, required this.mhsName});

  factory MsUser.fromJson(Map<String, dynamic> json) {
    return MsUser(
      nim: json['NIM'],
      mhsName: json['MhsName'],
    );
  }
}

class AllUserBookedSession {
  List<UserBookedSession>? data;
  BaseOutput? baseOutput;

  AllUserBookedSession({this.data, this.baseOutput});
  Map<String, dynamic> getAllUserBookedSessionResponse(
      Map<String, dynamic> json) {
    return {'data': json['Data'], 'baseOutput': json['BaseOutput']};
  }

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'data': data!.map((x) => x.toMap()).toList(),
      'baseOutput': baseOutput?.toMap(),
    };
  }

  factory AllUserBookedSession.fromJson(Map<String, dynamic> json) {
    return AllUserBookedSession(
      // data: json['Data'],
      data: List<UserBookedSession>.from(
          json["Data"].map((x) => UserBookedSession.fromJson(x))),
      baseOutput: BaseOutput.fromJson(json['BaseOutput']),
    );
  }

  factory AllUserBookedSession.fromMap(Map<String, dynamic> map) {
    return AllUserBookedSession(
      data: map['data'] != null
          ? List<UserBookedSession>.from(
              (map['data'] as List<int>).map<UserBookedSession?>(
                (x) => UserBookedSession.fromMap(x as Map<String, dynamic>),
              ),
            )
          : null,
      baseOutput: map['baseOutput'] != null
          ? BaseOutput.fromMap(map['baseOutput'] as Map<String, dynamic>)
          : null,
    );
  }

  String toJson() => json.encode(toMap());

  // factory AllUserBookedSession.fromJson(String source) =>
  //     AllUserBookedSession.fromMap(json.decode(source) as Map<String, dynamic>);
}

class UserBookedSession {
  String? bookingID;
  int? sessionID;
  int? bookingStatusID;
  int? lokerID;
  String? createdAt;
  UserBookedSession({
    this.bookingID,
    this.sessionID,
    this.bookingStatusID,
    this.lokerID,
    this.createdAt,
  });
  UserBookedSession.fromJson(Map<String, dynamic> json) {
    bookingID = json["BookingID"];
    sessionID = json["SessionID"];
    bookingStatusID = json["BookingStatusID"];
    lokerID = json["LokerID"];
    createdAt = json["CreatedAt"];
  }
  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'bookingID': bookingID,
      'sessionID': sessionID,
      'bookingStatusID': bookingStatusID,
      'lokerID': lokerID,
      'createdAt': createdAt,
    };
  }

  factory UserBookedSession.fromMap(Map<String, dynamic> map) {
    return UserBookedSession(
        bookingID: map['bookingID'] != null ? map['bookingID'] as String : null,
        sessionID: map['sessionID'] != null ? map['sessionID'] as int : null,
        bookingStatusID: map['bookingStatusID'] != null
            ? map['bookingStatusID'] as int
            : null,
        lokerID: map['lokerID'] != null ? map['lokerID'] as int : null,
        createdAt:
            map['createdAt'] != null ? map['createdAt'] as String : null);
  }
  Map<String, dynamic> getUserBookedSessionResponse(Map<String, dynamic> json) {
    return {
      'bookingID': json['bookingID'],
      'sessionID': json['sessionID'],
      'bookingStatusID': json['bookingStatusID'],
      'lokerID': json['lokerID'],
      'createdAt': json['createdAt'],
    };
  }

  String toJson() => json.encode(toMap());
}

class RequestUserBookedSession {
  String? userID;
  RequestUserBookedSession({
    this.userID,
  });

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'userID': userID,
    };
  }

  factory RequestUserBookedSession.fromMap(Map<String, dynamic> map) {
    return RequestUserBookedSession(
      userID: map['userID'] != null ? map['userID'] as String : null,
    );
  }

  String toJson() => json.encode(toMap());

  factory RequestUserBookedSession.fromJson(String source) =>
      RequestUserBookedSession.fromMap(
          json.decode(source) as Map<String, dynamic>);

  @override
  String toString() => 'RequestUserBookedSession(userID: $userID)';

  RequestUserBookedSession copyWith({
    String? userID,
  }) {
    return RequestUserBookedSession(
      userID: userID ?? this.userID,
    );
  }

  @override
  bool operator ==(covariant RequestUserBookedSession other) {
    if (identical(this, other)) return true;

    return other.userID == userID;
  }

  @override
  int get hashCode => userID.hashCode;
}
