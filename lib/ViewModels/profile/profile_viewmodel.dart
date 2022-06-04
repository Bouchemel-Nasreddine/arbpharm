import 'dart:convert';
import 'dart:io';

import 'package:arbpharm/Models/profile/profile_model.dart';
import 'package:file_picker/file_picker.dart';
import 'package:dio/dio.dart' as dio;
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';

import '../../configs/const.dart';

class ProfileViewModel extends ChangeNotifier {
  final model = ProfileModel();
  final refreshController = RefreshController();
  File? picture;
  bool pictureWorking = false;

  Future<File?> getProfilePic() async {
    FilePickerResult? result =
        await FilePicker.platform.pickFiles(type: FileType.image);

    if (result != null) {
      return File(result.files.single.path!);
    }
  }

  Future<void> getProfile() async {
    await Future.delayed(const Duration(seconds: 3));
    refreshController.loadComplete();
    return;
  }

  Future<void> storeProfilePic(BuildContext context) async {
    picture = await getProfilePic();
    if (picture == null) {
      return;
    }
    pictureWorking = true;
    notifyListeners();

    var picture64 = convertImageTo64(picture!);

    dio.Response? response = await model.storeProfilePic(picture: picture64);

    if (response == null) {
      pictureWorking = false;
      notifyListeners();
      return;
    }

    if (kDebugMode) {
      print(response.data);
    }

    if (response.statusCode == 204) {
      showSnackBar(
          context: context, message: "l'image a été mis à jour avec success");
    }

    pictureWorking = false;
    notifyListeners();
  }

  String convertImageTo64(File image) {
    List<int> imageBytes = image.readAsBytesSync();
    return base64Encode(imageBytes);
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
