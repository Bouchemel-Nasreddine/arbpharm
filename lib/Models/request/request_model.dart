import 'package:arbpharm/configs/base_api.dart';
import 'package:arbpharm/configs/generale_vars.dart';
import 'package:dio/dio.dart' as dio;
import 'package:flutter/foundation.dart';

class RequestModel {
  final _dioClient = dio.Dio();

  Future<dio.Response?> getRequests() async {
    try {
      dio.Response response = await _dioClient.get(
        requestEstimateUrl,
        options: dio.Options(
          headers: {
            "Authorization": "Bearer $tokenConst",
            "Accept": "application/json"
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
}
