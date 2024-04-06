class BaseOutput {
  int statusCode;
  String message;

  BaseOutput({required this.statusCode, required this.message});

  factory BaseOutput.fromJson(Map<String, dynamic> json) {
    return BaseOutput(
      statusCode: json['StatusCode'],
      message: json['Message'],
    );
  }
}
