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

  Future<dio.Response?> changePassword({
    required String oldPassword,
    required String newPassword,
    required String confirmationPassword,
  }) async {
    try {
      dio.Response response = await _dioClient.put(
        changePasswordUrl,
        options: dio.Options(
          headers: {
            "Accept": "application/json",
            "Authorization": 'Bearer $tokenConst',
          },
        ),
        data: {
          'old_password': oldPassword,
          'new_password': newPassword,
          'new_password_confirmation': confirmationPassword,
        },
      );

      return response;
    } on dio.DioError catch (e) {
      if (kDebugMode) {
        print(e);
      }
      return e.response;
    }
  }

  upadateProfileInfo({
    required String email,
    required String phone,
    required String commercialName,
    required String socialName,
    required int numRc,
    required int nif,
    required int nis,
    required int numAr,
    required String socialPlace,
    required int actCode,
  }) async {
    try {
      dio.Response response = await _dioClient.put(
        updateProfileUrl,
        options: dio.Options(
          headers: {
            "Accept": "application/json",
            "Authorization": 'Bearer $tokenConst',
          },
        ),
        data: {
          "email": email,
          "phone": phone,
          "social_name": socialName,
          "social_place": socialPlace,
          "commercial_name": commercialName,
          "num_rc": numRc,
          "nif": nif,
          "nis": nis,
          "num_ar": numAr,
          "activity_code": actCode,
        },
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
