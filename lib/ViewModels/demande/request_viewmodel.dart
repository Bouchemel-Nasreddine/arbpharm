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
  final offerNameController = TextEditingController();
  final offerQuantityController = TextEditingController();
  final offerMarqueController = TextEditingController();
  final offerPriceController = TextEditingController();
  List<Request> personalRequestsList = [];
  File? photo;
  File? offerPhoto;
  bool working = false;
  final refreshController = RefreshController();
  int historyPage = 1;
  bool hasNextPage = false;

  Future<void> getPic() async {
    FilePickerResult? result =
        await FilePicker.platform.pickFiles(type: FileType.image);

    if (result != null) {
      photo = File(result.files.single.path!);
      notifyListeners();
    }
  }

  Future<void> getOfferPic() async {
    FilePickerResult? result =
        await FilePicker.platform.pickFiles(type: FileType.image);

    if (result != null) {
      offerPhoto = File(result.files.single.path!);
      notifyListeners();
    }
  }

  String convertImageTo64(File image) {
    List<int> imageBytes = image.readAsBytesSync();
    return base64Encode(imageBytes);
  }

  getRequestHistory(BuildContext context) async {
    dio.Response? response = await model.getMyRequests(page: historyPage);

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
        // hasNextPage =
        //     response.data['last_page'] != response.data['current_page'];
        historyPage++;
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
    } else {
      working = false;
      notifyListeners();
      showSnackBar(context: context, message: 'erreur');
    }
  }

  postOffer(BuildContext context, int requestId) async {
    if (offerPhoto == null) return;

    working = true;
    notifyListeners();

    var picture64 = convertImageTo64(offerPhoto!);

    dio.Response? reqponse = await model.postOfferOnRequest(
      requestEstimateId: requestId,
      productName: offerNameController.text,
      amount: int.parse(offerQuantityController.text),
      mark: offerMarqueController.text,
      price: int.parse(offerPriceController.text),
      images: picture64,
    );

    if (reqponse == null) {
      showSnackBar(context: context, message: 'erreur');
      return;
    }

    working = false;
    notifyListeners();

    if (reqponse.statusCode == 200) {
      Navigator.pop(context);
      offerNameController.clear();
      offerMarqueController.clear();
      offerQuantityController.clear();
      offerPriceController.clear();
      offerPhoto = null;
      notifyListeners();
      showSnackBar(
          context: context, message: 'votre offer a été envoyé avec success');
    } else {
      working = false;
      notifyListeners();
      showSnackBar(context: context, message: 'erreur');
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
