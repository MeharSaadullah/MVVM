class AppException implements Exception {
  // AppException is class all other are keywords
  final _message;
  final _prefix;

  AppException([this._message, this._prefix]);

  @override
  String toString() {
    // TODO: implement toString
    return '$_prefix$_message';
  }
}

class FetchDataException extends AppException {
  FetchDataException([String? message])
      : super(message, 'Error during communication');
}

class BadRequestException extends AppException {
  BadRequestException([String? message]) : super(message, 'Invalid Request');
}

class UnAuthorizedException extends AppException {
  UnAuthorizedException([String? message])
      : super(message, 'UNauthorized exception');
}

class InvalidInputException extends AppException {
  InvalidInputException([String? message]) : super(message, 'Invalid INput');
}
