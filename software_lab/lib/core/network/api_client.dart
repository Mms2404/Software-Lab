import 'package:dio/dio.dart';
import 'package:fpdart/fpdart.dart';
import 'package:pretty_dio_logger/pretty_dio_logger.dart';
import 'package:software_lab/core/network/api_constants.dart';
import 'package:software_lab/core/network/failures.dart';

class ApiClient {
  static final ApiClient _instance = ApiClient._internal();
  factory ApiClient() => _instance;

  late final Dio _dio;
  Dio get dio => _dio;

  ApiClient._internal() {
    _dio = Dio(
      BaseOptions(
        baseUrl: ApiConstants.baseUrl,
        connectTimeout: const Duration(seconds: 10),
        receiveTimeout: const Duration(seconds: 10),
        responseType: ResponseType.json,
        headers: {
          "Content-Type": "application/json",
          "Accept": "application/json",
        },
      ),
    )..interceptors.add(
        PrettyDioLogger(
          requestHeader: true,
          requestBody: true,
          responseHeader: true,
          responseBody: true,
          error: true,
          compact: false,
        ),
      );
  }

  // MULTIPART POST (Register)
  Future<Either<Failure, Response>> postFormData(
    String path, {
    required FormData formData,
  }) async {
    try {
      final response = await _dio.post(
        path,
        data: formData,
        options: Options(
          headers: {
            "Content-Type": "multipart/form-data",
            "Accept": "application/json",
          },
        ),
      );
      return Right(response);
    } on DioException catch (e) {
      return Left(_handleDioException(e));
    } catch (e) {
      return Left(UnknownFailure(message: e.toString()));
    }
  }

  // JSON POST
  Future<Either<Failure, Response>> post(
    String path, {
    dynamic data,
    Map<String, dynamic>? queryParameters,
  }) async {
    try {
      final response = await _dio.post(
        path,
        data: data,
        queryParameters: queryParameters,
      );
      return Right(response);
    } on DioException catch (e) {
      return Left(_handleDioException(e));
    } catch (e) {
      return Left(UnknownFailure(message: e.toString()));
    }
  }

  // GET
  Future<Either<Failure, Response>> get(
    String path, {
    Map<String, dynamic>? queryParameters,
  }) async {
    try {
      final response = await _dio.get(
        path,
        queryParameters: queryParameters,
      );
      return Right(response);
    } on DioException catch (e) {
      return Left(_handleDioException(e));
    } catch (e) {
      return Left(UnknownFailure(message: e.toString()));
    }
  }

  Failure _handleDioException(DioException e) {
    if (e.type == DioExceptionType.connectionError) {
      return const NetworkFailure(
        message: "No internet connection. Please check your network.",
      );
    }

    if (e.type == DioExceptionType.connectionTimeout ||
        e.type == DioExceptionType.receiveTimeout ||
        e.type == DioExceptionType.sendTimeout) {
      return const TimeoutFailure(
        message: "Connection timed out. Please try again.",
      );
    }

    if (e.response != null) {
      final data = e.response?.data;
      String message = "Server error (${e.response?.statusCode})";

      if (data is Map && data.containsKey("message")) {
        message = data["message"];
      }

      return ServerFailure(
        message: message,
        statusCode: e.response?.statusCode,
      );
    }

    return const UnknownFailure(
      message: "Something went wrong. Please try again.",
    );
  }
}