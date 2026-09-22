import 'package:dio/dio.dart';
import 'exceptions.dart';

Exception mapDioExceptionToException(DioException exception) {
  switch (exception.type) {
    case DioExceptionType.connectionError:
    case DioExceptionType.connectionTimeout:
    case DioExceptionType.receiveTimeout:
    case DioExceptionType.sendTimeout:
      return NetworkException();

    case DioExceptionType.badResponse:
      final statusCode = exception.response?.statusCode;

      switch (statusCode) {
        case 401:
        case 403:
          return UnauthorizedException();

        case 404:
          return NotFoundException();

        case 500:
        case 502:
        case 503:
        case 504:
          return ServerException();

        default:
          return ServerException();
      }

    default:
      return ServerException();
  }
}
