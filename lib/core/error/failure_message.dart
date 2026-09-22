import 'failures.dart';

String getFailureMessage(Object error) {
  if (error is Failure) {
    return error.message; //NetworkFailure().message
  }
  return 'Something went wrong. Please try again later';
}
