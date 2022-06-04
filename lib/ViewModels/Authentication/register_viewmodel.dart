import 'dart:convert';
import 'dart:io';

import 'package:arbpharm/Data%20Models/user.dart';
import 'package:arbpharm/Models/Authentication/register_model.dart';
import 'package:arbpharm/configs/const.dart';
import 'package:arbpharm/configs/generale_vars.dart';
import 'package:file_picker/file_picker.dart';
import 'package:dio/dio.dart' as dio;
import 'package:http/http.dart' as http;
import 'package:flutter/material.dart';
import 'package:flutter/foundation.dart';
import 'package:shared_preferences/shared_preferences.dart';

class RegisterViewModel extends ChangeNotifier {
  final model = RegisterModel();
  final emailController = TextEditingController();
  final phoneController = TextEditingController();
  final passwordController = TextEditingController();
  final commercialNameController = TextEditingController();
  final socialNameController = TextEditingController();
  final nrcController = TextEditingController();
  final nifController = TextEditingController();
  final nisController = TextEditingController();
  final narController = TextEditingController();
  final adrController = TextEditingController();
  final actCodeController = TextEditingController();
  File? profilePic = null;
  List<File?> paymentProofs = [];
  bool working = false;

  getProfilePic() async {
    FilePickerResult? result =
        await FilePicker.platform.pickFiles(type: FileType.image);

    if (result != null) {
      profilePic = File(result.files.single.path!);
      notifyListeners();
    }
  }

  getProofsPics(BuildContext context) async {
    if (working) return;
    if (paymentProofs.length == 4) {
      showSnackBar(
        context: context,
        message:
            '4 photos sont requies, prendre une photo pour chaque élement demandé',
      );
      return;
    }
    FilePickerResult? result = await FilePicker.platform
        .pickFiles(type: FileType.image, allowMultiple: true);

    if (result != null) {
      for (var f in result.paths) {
        if (f != null) var file = File(f);
        if (f != null) paymentProofs.add(File(f));
      }
      notifyListeners();
    }
  }

  void register(BuildContext context) async {
    working = true;
    notifyListeners();
    String base64Profile =
        profilePic == null ? '' : convertImageTo64(profilePic!);
    List<String> list = [];

    for (var image in paymentProofs) {
      if (image == null) return;
      list.add(convertImageTo64(image));
    }

    dio.Response? response = await model.register(
      phone: phoneController.text,
      email: emailController.text,
      password: passwordController.text,
      commercialName: commercialNameController.text,
      activityCode: actCodeController.text,
      socialName: socialNameController.text,
      socialPlace: adrController.text,
      nif: nifController.text,
      nis: nisController.text,
      numAR: narController.text,
      numRC: nrcController.text,
      profilePic: base64Profile,
      images: list,
    );

    if (response == null) {
      showSnackBar(
          context: context, message: "erreur dans la création du compte");
      working = false;
      notifyListeners();
      return;
    }

    if (kDebugMode) {
      print(response.data);
    }

    if (response.statusCode == 200) {
      userCont = User.fromJson(response.data);
      if (userCont.connected) {
        (await SharedPreferences.getInstance()).setInt("id", userCont.id);
        navigateToHome(context);
      }
    } else if (response.statusCode == 422) {
      displayErrors(context: context, data: response.data);
    } else {
      showSnackBar(
          context: context, message: "erreur dans la création du compte");
    }

    working = false;
    notifyListeners();
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

  removeProof(int i) {
    paymentProofs.removeAt(i);
    notifyListeners();
  }

  navigateToHome(BuildContext context) {
    Navigator.pushNamedAndRemoveUntil(
      context,
      '/generale_home_view',
      (route) => false,
    );
  }
}
