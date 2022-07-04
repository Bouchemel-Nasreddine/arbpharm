import 'dart:convert';
import 'dart:io';

import 'package:arbpharm/Data%20Models/request.dart';
import 'package:arbpharm/Models/request/request_model.dart';
import 'package:file_picker/file_picker.dart';
import 'package:dio/dio.dart' as dio;
import 'package:flutter/material.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';

import '../../configs/const.dart';

class RequestViewModel extends ChangeNotifier {
  final model = RequestModel();
  final nameController = TextEditingController();
  final quantityController = TextEditingController();
  final marqueController = TextEditingController();
  List<Request> personalRequestsList = [];
  File? photo;
  bool working = false;
  final refreshController = RefreshController();

  Future<void> getPic() async {
    FilePickerResult? result =
        await FilePicker.platform.pickFiles(type: FileType.image);

    if (result != null) {
      photo = File(result.files.single.path!);
      notifyListeners();
    }
  }

  String convertImageTo64(File image) {
    List<int> imageBytes = image.readAsBytesSync();
    return base64Encode(imageBytes);
  }

  getRequestHistory(BuildContext context) async {
    dio.Response? response = await model.getMyRequests();

    if (response == null) {
      showSnackBar(
          context: context, message: "erreur lors de l'obtention d'historique");
      return;
    }

    if (response.statusCode == 200) {
      if (response.data != "") {
        personalRequestsList.clear();
        for (var req in response.data) {
          personalRequestsList.add(Request.fromJson(req));
        }
      }
    }
  }

  Future<void> refresh() async {
    notifyListeners();
  }

  postRequest(BuildContext context) async {
    if (photo == null) return;

    working = true;
    notifyListeners();

    var picture64 = convertImageTo64(photo!);

    dio.Response? reqponse = await model.postRequest(
      productName: nameController.text,
      amount: int.parse(quantityController.text),
      mark: marqueController.text,
      images: [picture64],
    );

    if (reqponse == null) {
      showSnackBar(context: context, message: 'erreur');
      return;
    }

    working = false;
    notifyListeners();

    if (reqponse.statusCode == 200) {
      Navigator.pop(context);
      Navigator.pop(context);
      nameController.clear();
      marqueController.clear();
      quantityController.clear();
      photo = null;
      notifyListeners();
      showSnackBar(
          context: context, message: 'votre demande a été envoyé avec success');
    }
  }

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
