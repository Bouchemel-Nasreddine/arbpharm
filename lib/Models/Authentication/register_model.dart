import 'dart:convert';

import 'package:arbpharm/configs/base_api.dart';
import 'package:dio/dio.dart' as dio;
import 'package:http/http.dart' as http;
import 'package:flutter/foundation.dart';

class RegisterModel {
  final dio.Dio _dioClient = dio.Dio();

  Future<dio.Response?> register({
    required String phone,
    required String email,
    required String password,
    required String commercialName,
    String numRC = '',
    String nif = '',
    String nis = '',
    String numAR = '',
    required String activityCode,
    required String socialName,
    required String socialPlace,
    required String? profilePic,
    required List<String> images,
  }) async {
    dio.FormData _formData = dio.FormData.fromMap(
      {
        "phone": phone,
        "email": email,
        "password": password,
        "commercial_name": commercialName,
        "num_rc": numRC,
        "nif": nif,
        "nis": nis,
        "num_ar": numAR,
        "social_name": socialName,
        "social_place": socialPlace,
        "activity_code": activityCode,
        "profile_pic": profilePic!,
        "images": [
          images[0],
          images[1],
          images[2],
          images[3],
        ],
      },
    );
    if (kDebugMode) {
      print('connecting to: $registerUrl');
    }
    try {
      dio.Response response = await _dioClient.post(
        registerUrl,
        data: _formData,
        options: dio.Options(
          headers: {
            "Content-type": "application/json",
            "Accept": "application/json",
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

  parseUserData({required String data}) {
    var jsonData = jsonEncode(data);
  }

  Future<http.Response> registerHttp({
    required String phone,
    required String email,
    required String password,
    required String commercialName,
    String numRC = '',
    String nif = '',
    String nis = '',
    String numAR = '',
    required String activityCode,
    required String socialName,
    required String socialPlace,
    required String? profilePic,
    required List<String> images,
  }) async {
    var body = jsonEncode(
      {
        "phone": phone,
        "email": email,
        "password": password,
        "commercial_name": commercialName,
        "num_rc": numRC,
        "nif": nif,
        "nis": nis,
        "num_ar": numAR,
        "social_name": socialName,
        "social_place": socialPlace,
        "activity_code": activityCode,
        "profile_pic": profilePic!,
        "images": [
          images[0],
          images[1],
          images[2],
          images[3],
        ],
      },
    );

    http.Response response = await http.post(
      Uri.parse(registerUrl),
      body: body,
      headers: {
        "Content-type": "application/json",
        "Accept": "application/json",
      },
    );

    return response;
  }
}
