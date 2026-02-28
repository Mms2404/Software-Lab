import 'package:dio/dio.dart';

class ApiExceptions {
  ApiExceptions._();

  static String handle(DioException e) {
    if (e.type == DioExceptionType.connectionError) {
      return "No internet connection. Please check your network.";
    }

    if (e.type == DioExceptionType.connectionTimeout ||
        e.type == DioExceptionType.receiveTimeout) {
      return "Connection timed out. Please try again.";
    }

    if (e.response != null) {
      final data = e.response?.data;

      if (data is Map && data.containsKey("message")) {
        return data["message"];
      }

      return "Server error (${e.response?.statusCode})";
    }

    return "Something went wrong. Please try again.";
  }
}