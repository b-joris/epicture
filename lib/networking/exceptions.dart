/// Exception throwed when an error occured with the API
class ImgurException implements Exception {
  final String _prefix;
  final String _message;

  ImgurException(this._prefix, this._message);

  String toString() {
    return '$_prefix$_message';
  }
}

/// Exception thrown when the API response status is 400
class BadRequestException extends ImgurException {
  BadRequestException(String message) : super('Invalid Request: ', message);
}

/// Exception thrown when the API response status is 401 or 403
class UnauthorisedException extends ImgurException {
  UnauthorisedException(String message) : super('Unauthorised: ', message);
}

/// Exception thrown when the API response status is unknonw
class FetchDataException extends ImgurException {
  FetchDataException(String message)
      : super('Error During Communication: ', message);
}
