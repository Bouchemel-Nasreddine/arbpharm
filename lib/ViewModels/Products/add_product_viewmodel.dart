import 'dart:convert';
import 'dart:io';

import 'package:arbpharm/Models/product/product_model.dart';
import 'package:dio/dio.dart' as dio;
import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';

import '../../configs/const.dart';

class AddProductViewModel extends ChangeNotifier {
  final model = ProductsModel();
  final descriptionController = TextEditingController();
  File? techFile;
  List<File?> productPics = [];
  File? profilePic = null;

  bool working = false;
  final refreshController = RefreshController();
  int historyPage = 1;
  bool hasNextPage = true;

  postProduct(BuildContext context) async {
    working = true;
    notifyListeners();

    List<String> pics = [];

    for (var i in productPics) {
      pics.add(convertImageTo64(i!));
    }

    dio.Response? response = await model.postProduct(
      description: descriptionController.text,
      images: pics,
    );

    if (response == null) {
      showSnackBar(context: context, message: 'erreur');
      return;
    }

    working = false;
    notifyListeners();

    if (response.statusCode == 200) {
      Navigator.pop(context);
      Navigator.pop(context);
      descriptionController.clear();
      notifyListeners();
      showSnackBar(
          context: context, message: 'votre produit a été publié avec success');
    } else {
      working = false;
      notifyListeners();
      showSnackBar(context: context, message: 'erreur');
    }
  }

  getProfilePic() async {
    FilePickerResult? result =
        await FilePicker.platform.pickFiles(type: FileType.image);

    if (result != null) {
      profilePic = File(result.files.single.path!);
      notifyListeners();
    }
  }

  getProductPics(BuildContext context) async {
    if (working) return;
    if (productPics.length == 4) {
      showSnackBar(
        context: context,
        message: '4 photos est le maximum',
      );
      return;
    }
    FilePickerResult? result = await FilePicker.platform
        .pickFiles(type: FileType.image, allowMultiple: true);

    if (result != null) {
      for (var f in result.paths) {
        if (f != null) productPics.add(File(f));
      }
      notifyListeners();
    }
  }

  String convertImageTo64(File image) {
    List<int> imageBytes = image.readAsBytesSync();
    return base64Encode(imageBytes);
  }

  displayErrors(
      {required BuildContext context, required Map<String, dynamic> data}) {
    String message = "";
    var errors = data['errors'];
    errors.forEach((key, value) {
      message = message + value[0] + '\n';
    });
    message = message.substring(0, message.length - 1);
    showSnackBar(context: context, message: message);
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

  removePics(int i) {
    productPics.removeAt(i);
    notifyListeners();
  }
}
