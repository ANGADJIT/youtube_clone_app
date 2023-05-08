import 'dart:io';

import 'package:dio/dio.dart';
import 'package:flutter/foundation.dart';
import 'package:path_provider/path_provider.dart';
import 'package:youtube_clone_app/src/utils/base_api.dart';
import 'package:youtube_clone_app/src/utils/exceptions.dart';

class RawVideoApi extends BaseApi {
  Future<String> uploadRawImage(Uint8List thumbnail) async {
    String uploadKey = '';

    final Map<String, dynamic> headers = {
      'accept': 'application/json',
      'Content-Type': 'multipart/form-data'
    };

    final Directory tempDir = await getTemporaryDirectory();

    final File imageFile =
        await File('${tempDir.path}/thumbnail.png').writeAsBytes(thumbnail);

    try {
      final Response response = await post(
          route: 'upload_raw_video',
          data: {},
          headers: headers,
          isDepended: true,
          isForm: true,
          file: imageFile);

      if (response.statusCode == 200) {
        uploadKey = response.data['upload_key'];
      }
    } catch (e) {
      throw ServerException('Something went wrong');
    }

    return uploadKey;
  }

  Future<String> uploadRawVideo(String video) async {
    String uploadKey = '';

    final Map<String, dynamic> headers = {
      'accept': 'application/json',
      'Content-Type': 'multipart/form-data'
    };

    File videoFile = File(video);

    try {
      final Response response = await post(
          route: 'upload_raw_video',
          headers: headers,
          data: {},
          isDepended: true,
          isForm: true,
          file: videoFile);

      if (response.statusCode == 200) {
        uploadKey = response.data['upload_key'];
      }
    } catch (e) {
      throw ServerException('Something went wrong');
    }

    return uploadKey;
  }
}
