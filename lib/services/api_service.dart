import 'dart:io';
import 'dart:convert';
import 'package:flutter/widgets.dart';
import 'package:http/http.dart' as http;
import 'package:internet_originals/services/shared_prefs_service.dart';

class ApiService {
  final String devUrl = "http://10.10.12.126:3929/api/v1";
  final String prodUrl = "";
  final bool inDevelopment = true;
  final bool showAPICalls = true;

  late final String baseUrl;

  ApiService() {
    baseUrl = inDevelopment ? devUrl : prodUrl;
  }

  void _logResponse(http.Response response, String method, Uri uri) {
    debugPrint('📥 [$method] Response from ${uri.toString()}');
    debugPrint('✅ Status Code: ${response.statusCode}');
    debugPrint('📦 Body: ${response.body}');
  }

  Future<Map<String, String>> _getHeaders(bool authReq) async {
    Map<String, String> headers = {'Content-Type': 'application/json'};
    if (authReq) {
      final token = await SharedPrefsService.get('token');
      headers['Authorization'] = 'Bearer $token';
    }
    return headers;
  }

  // Create
  Future<http.Response> post(
    String endpoint,
    Map<String, dynamic> data, {
    Map<String, dynamic>? queryParams,
    bool isMultiPart = false,
    bool authReq = false,
  }) async {
    try {
      final headers = await _getHeaders(authReq);
      final uri = Uri.parse(
        '$baseUrl$endpoint',
      ).replace(queryParameters: queryParams);

      http.Response response;

      if (isMultiPart) {
        var request = http.MultipartRequest('POST', uri);
        request.headers.addAll(headers);

        for (var entry in data.entries) {
          if (entry.value is File) {
            request.files.add(
              await http.MultipartFile.fromPath(
                entry.key,
                (entry.value as File).path,
              ),
            );
          } else if (entry.value is List<File>) {
            // List of Files
            for (var file in (entry.value as List<File>)) {
              request.files.add(
                await http.MultipartFile.fromPath(entry.key, file.path),
              );
            }
          } else {
            request.fields[entry.key] = entry.value.toString();
          }
        }

        var streamedResponse = await request.send();
        response = await http.Response.fromStream(streamedResponse);
      } else {
        response = await http.post(
          uri,
          headers: headers,
          body: jsonEncode(data),
        );
      }

      if (showAPICalls) _logResponse(response, 'POST', uri);

      return response;
    } catch (e) {
      debugPrint('❗ POST Error: $e');
      throw Exception('Something went wrong. Please try again.');
    }
  }

  // Read
  Future<http.Response> get(
    String endpoint, {
    Map<String, dynamic>? queryParams,
    bool authReq = false,
  }) async {
    try {
      final headers = await _getHeaders(authReq);
      final uri = Uri.parse(
        '$baseUrl$endpoint',
      ).replace(queryParameters: queryParams);
      final response = await http.get(uri, headers: headers);

      if (showAPICalls) _logResponse(response, 'GET', uri);

      return response;
    } catch (e) {
      debugPrint('❗ GET Error: $e');
      throw Exception('Something went wrong. Please try again.');
    }
  }

  // Patch (Update)
  Future<http.Response> patch(
    String endpoint,
    Map<String, dynamic> data, {
    bool isMultiPart = false,
    bool authReq = false,
  }) async {
    try {
      final headers = await _getHeaders(authReq);
      final uri = Uri.parse('$baseUrl$endpoint');

      http.Response response;

      if (isMultiPart) {
        var request = http.MultipartRequest('PATCH', uri);
        request.headers.addAll(headers);

        for (var entry in data.entries) {
          if (entry.value is File) {
            request.files.add(
              await http.MultipartFile.fromPath(
                entry.key,
                (entry.value as File).path,
              ),
            );
          } else if (entry.value is List<File>) {
            // List of Files
            for (var file in (entry.value as List<File>)) {
              request.files.add(
                await http.MultipartFile.fromPath(entry.key, file.path),
              );
            }
          } else {
            request.fields[entry.key] = jsonEncode(entry.value);
          }
        }

        var streamedResponse = await request.send();
        response = await http.Response.fromStream(streamedResponse);
      } else {
        response = await http.patch(
          uri,
          headers: headers,
          body: jsonEncode(data),
        );
      }

      if (showAPICalls) _logResponse(response, 'PATCH', uri);

      return response;
    } catch (e) {
      debugPrint('❗ PATCH Error: $e');
      throw Exception('Something went wrong. Please try again.');
    }
  }

  // Delete
  Future<http.Response> delete(
    String endpoint, {
    Map<String, dynamic>? data,
    bool authReq = false,
  }) async {
    try {
      final headers = await _getHeaders(authReq);
      final uri = Uri.parse('$baseUrl$endpoint');
      final response = await http.delete(
        uri,
        headers: headers,
        body: jsonEncode(data),
      );

      if (showAPICalls) _logResponse(response, 'DELETE', uri);

      return response;
    } catch (e) {
      debugPrint('❗ DELETE Error: $e');
      throw Exception('Something went wrong. Please try again.');
    }
  }

  Future<void> setToken(String token) async {
    await SharedPrefsService.set('token', token);
    debugPrint('💾 Token Saved: $token');
  }
}
