abstract class Failure {
  String get message;
}

class NetworkFailure extends Failure {
  @override
  String get message => 'Check your internet connection';
}

class ServerFailure extends Failure {
  @override
  String get message => 'Server error. Please try again later';
}

class UnauthorizedFailure extends Failure {
  @override
  String get message => 'Authorization failed';
}

class NotFoundFailure extends Failure {
  @override
  String get message => 'Movie not found';
}

class ParsingFailure extends Failure {
  @override
  String get message => 'Something went wrong while reading the data';
}
