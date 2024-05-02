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
