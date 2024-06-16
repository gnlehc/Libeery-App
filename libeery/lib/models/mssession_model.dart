class MsSession {
  final int sessionID;
  final DateTime startSession;
  final DateTime endSession;

  MsSession({
    required this.sessionID,
    required this.startSession,
    required this.endSession,
  });

  factory MsSession.fromJson(Map<String, dynamic> json) {
    return MsSession(
      sessionID: json['SessionID'],
      startSession: DateTime.parse(json['StartSession']),
      endSession: DateTime.parse(json['EndSession']),
    );
  }
}

class ListMsSession {
  final List<MsSession> data;
  final String message;
  final int statusCode;

  ListMsSession({
    required this.data,
    required this.message,
    required this.statusCode,
  });

  factory ListMsSession.fromJson(Map<String, dynamic> json) {
    List<MsSession> sessions = [];
    if (json['Data'] != null) {
      sessions =
          List<MsSession>.from(json['Data'].map((e) => MsSession.fromJson(e)));
    }

    return ListMsSession(
      data: sessions,
      message: json['BaseOutput']['Message'],
      statusCode: json['BaseOutput']['StatusCode'],
    );
  }
}

class SessionRequestDTO {
  final String userID;
  final int sessionID;
  final int lokerID;

  SessionRequestDTO({
    required this.userID,
    required this.sessionID,
    required this.lokerID,
  });

  Map<String, dynamic> toJson() {
    return {
      'UserID': userID,
      'SessionID': sessionID,
      'LokerID': lokerID,
    };
  }
}

class MsSessionForNow {
  // final int sessionID;
  final DateTime startSession;
  final DateTime endSession;

  MsSessionForNow({
    // required this.sessionID,
    required this.startSession,
    required this.endSession,
  });

  factory MsSessionForNow.fromJson(Map<String, dynamic> json) {
    return MsSessionForNow(
      startSession: DateTime.parse("${json['StartSession']}+07:00"),
      endSession: DateTime.parse("${json['EndSession']}+07:00"),
    );
  }
}

class ListMsSessionForNow {
  final List<MsSessionForNow> data;
  final String message;
  final int statusCode;

  ListMsSessionForNow({
    required this.data,
    required this.message,
    required this.statusCode,
  });

  factory ListMsSessionForNow.fromJson(Map<String, dynamic> json) {
    List<MsSessionForNow> sessions = [];
    if (json['Data'] != null) {
      sessions = List<MsSessionForNow>.from(
          json['Data'].map((e) => MsSessionForNow.fromJson(e)));
    }

    return ListMsSessionForNow(
      data: sessions,
      message: json['BaseOutput']['Message'],
      statusCode: json['BaseOutput']['StatusCode'],
    );
  }
}

class SessionForNowRequestDTO {
  final String userID;
  final String startSession;
  final String endSession;
  final int lokerID;

  SessionForNowRequestDTO({
    required this.userID,
    required this.startSession,
    required this.endSession,
    required this.lokerID,
  });

  Map<String, dynamic> toJson() {
    return {
      'UserID': userID,
      'StartSession': startSession,
      'EndSession': endSession,
      'LokerID': lokerID,
    };
  }
}
