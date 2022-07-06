import 'package:arbpharm/Data%20Models/request.dart';
import 'package:arbpharm/Models/request/request_model.dart';
import 'package:dio/dio.dart' as dio;
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';

import '../../configs/const.dart';

class HomeViewModel extends ChangeNotifier {
  bool working = true;
  final requestModel = RequestModel();
  List<Request> requestList = [];
  int requestPage = 1;
  bool requestHasNextPage = true;

  Future<void> getRequests(BuildContext context) async {
    dio.Response? response = await requestModel.getRequests(page: requestPage);

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
        if (requestPage == 1) requestList.clear();
        var data = response.data['data'];
        for (var req in data) {
          requestList.add(Request.fromJson(req));
        }
        requestHasNextPage =
            response.data['last_page'] != response.data['current_page'];
        requestPage++;
      }
    }

    working = false;
    notifyListeners();
  }

  // Widget getRequestsList() {}

  showSnackBar(
      {required BuildContext context,
      required String message,
      Duration duration = const Duration(seconds: 4)}) {
    final snackBar = SnackBar(
      content: Text(message),
      backgroundColor: elictricBlue,
      behavior: SnackBarBehavior.floating,
      duration: duration,
    );
    ScaffoldMessenger.of(context).showSnackBar(snackBar);
  }
}
