import 'package:dio/dio.dart' as dio;
import 'package:flutter/foundation.dart';

import '../../configs/base_api.dart';
import '../../configs/generale_vars.dart';

class ProductsModel {
  final _dioClient = dio.Dio();

  Future<dio.Response?> getProducts({int page = 1}) async {
    try {
      dio.Response response = await _dioClient.get(
        productsUrl,
        options: dio.Options(
          headers: {
            "Authorization": "Bearer $tokenConst",
            "Accept": "application/json"
          },
        ),
        queryParameters: {'page': page},
      );

      return response;
    } on dio.DioError catch (e) {
      if (kDebugMode) {
        print(e);
      }
      return e.response;
    }
  }

  Future<dio.Response?> getMyProducts({int page = 1}) async {
    try {
      dio.Response response =
          await _dioClient.get('$productsUrl/${userConst.id}',
              options: dio.Options(
                headers: {
                  "Authorization": "Bearer $tokenConst",
                  "Accept": "application/json"
                },
              ),
              queryParameters: {'page': page});

      return response;
    } on dio.DioError catch (e) {
      if (kDebugMode) {
        print(e);
      }
      return e.response;
    }
  }

  Future<dio.Response?> postProduct({
    required String productName,
    required int amount,
    required String mark,
    int? price,
    required List<String> images,
  }) async {
    try {
      dio.Response response = await _dioClient.post(
        productsUrl,
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
}
