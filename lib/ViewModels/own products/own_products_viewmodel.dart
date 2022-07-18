import 'package:arbpharm/Data%20Models/product.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:dio/dio.dart' as dio;

import '../../Models/product/product_model.dart';

class OwnProductsViewModel extends ChangeNotifier {
  final model = ProductsModel();

  List<Product> productsList = [];

  bool gettingProducts = true;
  bool working = true;
  bool productsHasNextPage = false;

  int productsPage = 1;

  Future<void> getProducts(BuildContext context) async {
    gettingProducts = true;
    dio.Response? response = await model.getMyProducts(page: productsPage);

    if (response == null) {
      working = false;
      notifyListeners();
      return;
    }

    if (kDebugMode) {
      print(response.data);
    }

    if (response.statusCode == 200) {
      if (response.data != "") {
        if (productsPage == 1) productsList.clear();
        var data = response.data;
        for (var req in data) {
          productsList.add(Product.fromJson(req));
        }
        // productsHasNextPage =
        //     response.data['last_page'] != response.data['current_page'];
        productsPage++;
      }
    }

    working = false;
    gettingProducts = false;
    notifyListeners();
  }
}
