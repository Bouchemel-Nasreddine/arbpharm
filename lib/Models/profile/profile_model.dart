import 'package:arbpharm/configs/base_api.dart';
import 'package:flutter/foundation.dart';
import 'package:http/http.dart' as http;
import 'package:dio/dio.dart' as dio;
import 'package:shared_preferences/shared_preferences.dart';

import '../../configs/generale_vars.dart';

class ProfileModel {
  final _dioClient = dio.Dio();

  Future<http.Response> getProfile({
    required int id,
    required String token,
  }) async {
    try {
      http.Response response = await http.get(
        Uri.parse('$profileUrl/$id'),
        headers: {
          "Accept": "application/json",
          "Authorization": 'Bearer $token',
        },
      );

      return response;
    } on Exception catch (e) {
      if (kDebugMode) {
        print(e);
      }
      return http.Response('', 550);
    }
  }

  Future<dio.Response?> getProfileDetails() async {
    try {
      dio.Response response = await _dioClient.get(
        profileDetailsUrl,
        options: dio.Options(
          headers: {
            "Accept": "application/json",
            "Authorization": 'Bearer $tokenConst',
          },
        ),
      );

      return response;
    } on dio.DioError catch (e) {
      if (kDebugMode) {
        print(e);
      }
      return e.response;
    }
  }

  Future<dio.Response?> storeProfilePic({
    required String picture,
  }) async {
    try {
      var token = (await SharedPreferences.getInstance()).getString("token");

      dio.Response response = await _dioClient.post(
        storeProfilePicUrl,
        options: dio.Options(
          headers: {
            "Authorization": "Bearer $token",
            "Accept": "application/json"
          },
        ),
        data: dio.FormData.fromMap({
          "profile_pic": picture,
        }),
      );

      return response;
    } on dio.DioError catch (e) {
      if (kDebugMode) {
        print(e);
      }
      return e.response;
    }
  }
}
