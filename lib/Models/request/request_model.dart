import 'dart:convert';

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

  Future<dio.Response?> getMyRequests() async {
    try {
      dio.Response response = await _dioClient.get(
        '$getMyRequestsUrl/${userConst.id}',
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

  Future<dio.Response?> postRequest({
    required String productName,
    required int amount,
    required String mark,
    int? price,
    required List<String> images,
  }) async {
    try {
      dio.Response response = await _dioClient.post(
        requestEstimateUrl,
        options: dio.Options(
          headers: {
            "Authorization": "Bearer $tokenConst",
            "Accept": "application/json"
          },
        ),
        data: dio.FormData.fromMap({
          "product_name": productName,
          "amount": amount,
          "mark": mark,
          "images": images
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

  Future<dio.Response?> postOfferOnRequest({
    required int requestEstimateId,
    required String productName,
    required int amount,
    required String mark,
    required int price,
    required String images,
  }) async {
    try {
      dio.Response response = await _dioClient.post(
        postOfferUrl,
        options: dio.Options(
          headers: {
            "Authorization": "Bearer $tokenConst",
            "Accept": "application/json"
          },
        ),
        data: jsonEncode({
          "request_estimate_id": requestEstimateId,
          "product_name": productName,
          "amount": amount,
          "mark": mark,
          "price": price,
          "images": images
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
