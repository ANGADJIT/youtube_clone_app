import 'dart:io';
import 'package:flutter/cupertino.dart';
import 'package:flutter_config/flutter_config.dart';
import 'package:dio/dio.dart';
import 'cache_manager.dart';

class BaseApi {
  final Dio _dio = Dio(BaseOptions(baseUrl: FlutterConfig.get('API_URL')));

  @protected
  Future<Response> get(
      {required String route,
      required Map<String, dynamic> headers,
      bool isDepended = true}) async {
    if (isDepended) {
      headers['authorization'] = 'Bearer ${CacheManager.token}';
    }

    _dio.options.headers = headers;

    return await _dio.get(route);
  }

  @protected
  Future<Response> post(
      {required String route,
      required Map<String, dynamic> headers,
      File? file,
      bool isForm = false,
      Map<String, dynamic>? data,
      bool isDepended = true}) async {
    if (isDepended) {
      headers['authorization'] = CacheManager.token;
    }

    FormData? formData;

    if (file != null) {
      data!['file'] = await MultipartFile.fromFile(file.path);

      formData = FormData.fromMap(data);
    }

    _dio.options.headers = headers;

    if (isForm) {
      _dio.post(route, data: formData);
    }

    return _dio.post(route, data: data);
  }
}
