import 'package:arbpharm/configs/base_api.dart';
import 'package:dio/dio.dart' as dio;
import 'package:flutter/foundation.dart';

class LoginModel {
  final _dioClient = dio.Dio();

  //depending on the @has_phone , @loginParams sould be phone or email, 0 for email, 1 for phone
  Future<dio.Response?> login({
    required int hasPhone,
    required String loginParamName,
    required String loginParam,
    required String password,
  }) async {
    try {
      dio.Response response = await _dioClient.post(
        loginUrl,
        data: dio.FormData.fromMap(
          {
            'has_phone': hasPhone,
            loginParamName: loginParam,
            'password': password,
          },
        ),
        options: dio.Options(
          headers: {
            "Content-type": "application/json",
            "Accept": "application/json",
          },
        ),
      );

      if (kDebugMode) {
        print(response.data);
      }

      return response;
    } on dio.DioError catch (e) {
      if (kDebugMode) {
        print(e);
      }
      return e.response;
    }
  }

  Future<dio.Response?> forgetPassword({
    required String email,
  }) async {
    try {
      dio.Response response = await _dioClient.post(
        forgetPasswordUrl,
        data: dio.FormData.fromMap(
          {
            'email': email,
          },
        ),
        options: dio.Options(
          headers: {
            "Content-type": "application/json",
            "Accept": "application/json",
          },
        ),
      );

      if (kDebugMode) {
        print(response.data);
      }

      return response;
    } on dio.DioError catch (e) {
      if (kDebugMode) {
        print(e);
      }
      return e.response;
    }
  }

  Future<dio.Response?> resetPassword({
    required String codeActivation,
    required String newPassword,
    required String confirmationPassword,
  }) async {
    try {
      dio.Response response = await _dioClient.post(
        resetPasswordUrl,
        data: dio.FormData.fromMap(
          {
            'code_verification': codeActivation,
            'new_password': newPassword,
            'new_password_confirmation': confirmationPassword,
          },
        ),
        options: dio.Options(
          headers: {
            "Content-type": "application/json",
            "Accept": "application/json",
          },
        ),
      );

      if (kDebugMode) {
        print(response.data);
      }

      return response;
    } on dio.DioError catch (e) {
      if (kDebugMode) {
        print(e);
      }
      return e.response;
    }
  }
}
