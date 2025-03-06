// ignore_for_file: prefer_typing_uninitialized_variables, annotate_overrides

class AppException implements Exception {
  final _message;
  final _prefix;
  AppException([this._message, this._prefix]);

  String toString() {
    return '$_prefix$_message';
  }
}

class FetchDataException extends AppException {
  FetchDataException([String? super.message]);
}

class BadRequestException extends AppException {
  BadRequestException([String? super.message]);
}

class UnauthorisedException extends AppException {
  UnauthorisedException([String? super.message]);
}

class InvalidInputException extends AppException {
  InvalidInputException([String? super.message]);
}