import 'dart:convert';
import 'dart:io';

import 'package:arbpharm/Models/profile/profile_model.dart';
import 'package:arbpharm/Views/Authentication/login/login_view.dart';
import 'package:arbpharm/configs/generale_vars.dart';
import 'package:file_picker/file_picker.dart';
import 'package:dio/dio.dart' as dio;
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../Data Models/user.dart';
import '../../configs/const.dart';

class ProfileViewModel extends ChangeNotifier {
  final model = ProfileModel();
  final refreshController = RefreshController();
  File? picture;
  bool pictureWorking = false;
  bool working = false;

  Future<File?> getProfilePic() async {
    FilePickerResult? result =
        await FilePicker.platform.pickFiles(type: FileType.image);

    if (result != null) {
      return File(result.files.single.path!);
    }
  }

  Future<void> refresh() async {
    refreshController.loadComplete();
    notifyListeners();
    return;
  }

  Future<void> getProfileDetails() async {
    dio.Response? response = await model.getProfileDetails();

    if (response == null) {
      working = false;
      notifyListeners();
      return;
    }

    if (response.statusCode == 200) {
      userCont = User.fromJson(response.data['data']);
    }
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

  goToPage(BuildContext context, Widget destination) {
    Navigator.of(context).push(
      PageRouteBuilder(
        pageBuilder: ((context, animation, secondaryAnimation) => destination),
        transitionsBuilder: (context, a1, a2, child) => SlideTransition(
          position: Tween(
            begin: const Offset(1.0, 0.0),
            end: const Offset(0.0, 0.0),
          ).animate(a1),
          child: child,
        ),
      ),
    );
  }

  logout(BuildContext context) async {
    userCont = User.initialise();
    tokenConst = "";
    (await SharedPreferences.getInstance()).clear().whenComplete(() {
      Navigator.pushAndRemoveUntil(context,
          MaterialPageRoute(builder: (context) => Login()), (route) => false);
    });
  }
}
