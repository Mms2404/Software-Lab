sealed class Failure {
  final String message;
  const Failure(this.message);
}

class ServerFailure extends Failure {
  final int? statusCode;
  const ServerFailure({required String message, this.statusCode}) : super(message);
}

class NetworkFailure extends Failure {
  const NetworkFailure({required String message}) : super(message);
}

class TimeoutFailure extends Failure {
  const TimeoutFailure({required String message}) : super(message);
}

class UnknownFailure extends Failure {
  const UnknownFailure({required String message}) : super(message);
}