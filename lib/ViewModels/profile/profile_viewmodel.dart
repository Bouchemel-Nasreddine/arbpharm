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
  //for password change
  final oldPasswordController = TextEditingController();
  final newPasswordController = TextEditingController();
  final confirmPasswordController = TextEditingController();
  //for profile info update
  final emailController = TextEditingController();
  final phoneController = TextEditingController();
  final commercialNameController = TextEditingController();
  final socialNameController = TextEditingController();
  final nrcController = TextEditingController();
  final nifController = TextEditingController();
  final nisController = TextEditingController();
  final narController = TextEditingController();
  final adrController = TextEditingController();
  final actCodeController = TextEditingController();

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

  void changePassword(BuildContext context) async {
    working = true;
    notifyListeners();
    dio.Response? response = await model.changePassword(
      oldPassword: oldPasswordController.text,
      newPassword: newPasswordController.text,
      confirmationPassword: confirmPasswordController.text,
    );

    if (response == null) {
      showSnackBar(context: context, message: 'erruer lors du changement');
      working = false;
      notifyListeners();
      return;
    }

    if (response.statusCode == 204) {
      oldPasswordController.text = "";
      newPasswordController.text = "";
      confirmPasswordController.text = "";
      working = false;
      notifyListeners();
      Navigator.pop(context);
      showSnackBar(
          context: context, message: 'mot de passe changé avec success');
    } else if (response.statusCode == 422) {
      displayErrors(context: context, data: response.data);
    } else {
      showSnackBar(context: context, message: 'erruer lors du changement');
    }
    working = false;
    notifyListeners();
  }

  setFields() async {
    emailController.text = userCont.email;
    phoneController.text = userCont.phone;
    commercialNameController.text = userCont.getProfile.commercialName;
    socialNameController.text = userCont.getProfile.socialName;
    nrcController.text = userCont.getProfile.numRc;
    nifController.text = userCont.getProfile.nif;
    nisController.text = userCont.getProfile.nis ?? "";
    narController.text = userCont.getProfile.numAr ?? "";
    adrController.text = userCont.getProfile.socialPlace ?? "";
    actCodeController.text = userCont.getProfile.activityCode;
  }

  void upadateProfileInfo(BuildContext context) async {
    working = true;
    notifyListeners();
    dio.Response? response = await model.upadateProfileInfo(
      email: emailController.text,
      phone: phoneController.text,
      commercialName: commercialNameController.text,
      socialName: socialNameController.text,
      numRc: int.parse(nrcController.text),
      nif: int.parse(nifController.text),
      nis: int.parse(nisController.text),
      numAr: int.parse(narController.text),
      socialPlace: adrController.text,
      actCode: int.parse(actCodeController.text),
    );

    if (response == null) {
      showSnackBar(context: context, message: 'erruer lors du changement');
      working = false;
      notifyListeners();
      return;
    }

    if (response.statusCode == 204) {
      working = false;
      notifyListeners();
      Navigator.pop(context);
      showSnackBar(
          context: context, message: 'modifications sauvgardé avec success');
    } else if (response.statusCode == 422) {
      displayErrors(context: context, data: response.data);
    } else {
      showSnackBar(context: context, message: 'erruer lors du changement');
    }
    working = false;
    notifyListeners();
  }
}
