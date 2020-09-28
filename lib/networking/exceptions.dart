class ImgurException implements Exception {
  final String _prefix;
  final String _message;

  ImgurException(this._prefix, this._message);

  String toString() {
    return '$_prefix$_message';
  }
}

class BadRequestException extends ImgurException {
  BadRequestException(String message) : super('Invalid Request: ', message);
}

class UnauthorisedException extends ImgurException {
  UnauthorisedException(String message) : super('Unauthorised: ', message);
}

class InvalidInputException extends ImgurException {
  InvalidInputException(String message) : super('Invalid Input: ', message);
}

class FetchDataException extends ImgurException {
  FetchDataException(String message)
      : super('Error During Communication: ', message);
}
