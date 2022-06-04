import 'dart:convert';
import 'dart:io';

import 'package:arbpharm/Data%20Models/request.dart';
import 'package:arbpharm/Models/request/request_model.dart';
import 'package:file_picker/file_picker.dart';
import 'package:flutter/cupertino.dart';
import 'package:dio/dio.dart' as dio;
import 'package:flutter/material.dart';

import '../../configs/const.dart';

class RequestViewModel extends ChangeNotifier {
  final model = RequestModel();
  final nameController = TextEditingController();
  final quantityController = TextEditingController();
  final marqueController = TextEditingController();
  List<Request> personalRequestsList = [];
  File? photo;

  Future<File?> getProfilePic() async {
    FilePickerResult? result =
        await FilePicker.platform.pickFiles(type: FileType.image);

    if (result != null) {
      return File(result.files.single.path!);
    }
  }

  String convertImageTo64(File image) {
    List<int> imageBytes = image.readAsBytesSync();
    return base64Encode(imageBytes);
  }

  getRequestHistory(BuildContext context) async {
    dio.Response? response = await model.getRequests();

    if (response == null) {
      showSnackBar(
          context: context, message: "erreur lors de l'obtention d'historique");
      return;
    }

    if (response.statusCode == 200) {
      for (var req in response.data) {
        personalRequestsList.add(Request.fromJson(req));
      }
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
