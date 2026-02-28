import 'package:dio/dio.dart';
import 'package:pretty_dio_logger/pretty_dio_logger.dart';
import 'package:software_lab/core/network/api_constants.dart';
import 'package:software_lab/core/network/api_exceptions.dart';

class ApiClient {

  static final ApiClient _instance = ApiClient._internal();
  factory ApiClient() => _instance;

  late final Dio _dio;
  Dio get dio => _dio;

  ApiClient._internal(){
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
  Future<Response> postFormData(
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
      return response;
    } on DioException catch (e) {
      throw Exception(ApiExceptions.handle(e));
    }
  }

  // JSON POST
  Future<Response> post(
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
      return response;
    } on DioException catch (e) {
      throw Exception(ApiExceptions.handle(e));
    }
  }


  // GET
  Future<Response> get(
    String path, {
    Map<String, dynamic>? queryParameters,
  }) async {
    try {
      final response = await _dio.get(
        path,
        queryParameters: queryParameters,
      );
      return response;
    } on DioException catch (e) {
      throw Exception(ApiExceptions.handle(e));
    }
  }


}