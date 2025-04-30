import 'dart:io';
import 'package:dio/dio.dart';
import 'package:flutter/widgets.dart';
import 'package:internet_originals/services/shared_prefs_service.dart';

class ApiService {
  final String devUrl = "http://192.168.10.199:5005/api/v1";
  final String prodUrl = "";
  final bool inDevelopment = true;
  final bool showAPICalls = true;

  late final String baseUrl;
  final Dio _dio = Dio();

  ApiService() {
    baseUrl = inDevelopment ? devUrl : prodUrl;
    _dio.options.baseUrl = baseUrl;
    _dio.options.connectTimeout = const Duration(seconds: 10);
    _dio.options.receiveTimeout = const Duration(seconds: 10);
    _dio.options.headers = {'Content-Type': 'application/json'};

    _dio.interceptors.add(
      InterceptorsWrapper(
        onRequest: (options, handler) {
          if (showAPICalls) {
            debugPrint('📤 REQUEST => PATH: ${options.path}');
            debugPrint('📤 DATA: ${options.data}');
          }
          handler.next(options);
        },
        onResponse: (response, handler) {
          if (showAPICalls) {
            debugPrint(
              '✅ RESPONSE [${response.statusCode}] => PATH: ${response.requestOptions.path}',
            );
            debugPrint(response.data);
          }
          handler.next(response);
        },
        onError: (error, handler) {
          if (showAPICalls) {
            debugPrint(
              '❌ ERROR [${error.response?.statusCode}] => PATH: ${error.requestOptions.path}',
            );
            debugPrint(error.response?.data);
          }

          if (error.response?.statusCode == 401) {
            SharedPrefsService.remove('token');
          }

          handler.next(error);
        },
      ),
    );
  }

  Future<Options> _getOptions(bool authReq) async {
    if (authReq) {
      final token = await SharedPrefsService.get('token');
      return Options(
        headers: {
          'Authorization': 'Bearer $token',
          'Content-Type': 'application/json',
        },
      );
    }
    return Options(headers: {'Content-Type': 'application/json'});
  }

  // Create
  Future<Response> post(
    String endpoint,
    Map<String, dynamic> data, {
    bool authReq = false,
  }) async {
    try {
      bool hasFile = data.values.any(
        (value) => value is File? && value != null,
      );

      dynamic payload;
      if (hasFile) {
        final formData = FormData();
        for (final entry in data.entries) {
          final key = entry.key;
          final value = entry.value;
          if (value is File) {
            formData.files.add(
              MapEntry(
                key,
                await MultipartFile.fromFile(
                  value.path,
                  filename: value.path.split('/').last,
                ),
              ),
            );
          } else {
            formData.fields.add(MapEntry(key, value.toString()));
          }
        }
        payload = formData;
      } else {
        payload = data;
      }

      final options = await _getOptions(authReq);
      final response = await _dio.post(
        endpoint,
        data: payload,
        options: options,
      );
      return response;
    } on DioException catch (e) {
      print(e);
      debugPrint(
        '❗ API Error: ${e.response?.statusCode} ${e.response?.statusMessage}',
      );
      debugPrint('❗ API Error Data: ${e.response?.data}');
      throw Exception(
        e.response?.data['message'] ??
            'Something went wrong. Please try again.',
      );
    } catch (e) {
      throw Exception('Unexpected error occurred');
    }
  }

  // Read
  Future<Response> get(
    String endpoint, {
    Map<String, dynamic>? queryParams,
    bool authReq = false,
  }) async {
    try {
      final options = await _getOptions(authReq);
      final response = await _dio.get(
        endpoint,
        queryParameters: queryParams,
        options: options,
      );
      return response;
    } on DioException catch (e) {
      debugPrint(
        '❗ API Error: ${e.response?.statusCode} ${e.response?.statusMessage}',
      );
      debugPrint('❗ API Error Data: ${e.response?.data}');
      throw Exception(
        e.response?.data['message'] ??
            'Something went wrong. Please try again.',
      );
    } catch (e) {
      throw Exception('Unexpected error occurred');
    }
  }

  // Patch (Update)
  Future<Response> patch(
    String endpoint,
    Map<String, dynamic> data, {
    bool authReq = false,
  }) async {
    try {
      final options = await _getOptions(authReq);
      final response = await _dio.patch(endpoint, data: data, options: options);
      return response;
    } on DioException catch (e) {
      debugPrint(
        '❗ API Error: ${e.response?.statusCode} ${e.response?.statusMessage}',
      );
      debugPrint('❗ API Error Data: ${e.response?.data}');
      throw Exception(
        e.response?.data['message'] ??
            'Something went wrong. Please try again.',
      );
    } catch (e) {
      throw Exception('Unexpected error occurred');
    }
  }

  // Delete
  Future<Response> delete(String endpoint, {bool authReq = false}) async {
    try {
      final options = await _getOptions(authReq);
      final response = await _dio.delete(endpoint, options: options);
      return response;
    } on DioException catch (e) {
      debugPrint(
        '❗ API Error: ${e.response?.statusCode} ${e.response?.statusMessage}',
      );
      debugPrint('❗ API Error Data: ${e.response?.data}');
      throw Exception(
        e.response?.data['message'] ??
            'Something went wrong. Please try again.',
      );
    } catch (e) {
      throw Exception('Unexpected error occurred');
    }
  }

  Future<void> setToken(String token) async {
    await SharedPrefsService.set('token', token);
  }
}
