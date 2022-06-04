import 'package:arbpharm/ViewModels/demande/request_viewmodel.dart';
import 'package:arbpharm/Views/Component/back_app_bar.dart';
import 'package:arbpharm/Views/Component/custom_circular_progress_indicator.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../configs/size_config.dart';

class RequestHistory extends StatelessWidget {
  const RequestHistory({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: PreferredSize(
        child: CustomBackAppBar(title: 'Historique des demandes'),
        preferredSize:
            Size(SizeConfig.screenWidth, SizeConfig.screenHeight * 0.09),
      ),
      body: Consumer<RequestViewModel>(
        builder: (context, value, child) => FutureBuilder(
            future: value.getRequestHistory(context),
            builder: (context, snapShot) =>
                snapShot.connectionState == ConnectionState.waiting
                    ? const CustomCircuarProgressIdicator()
                    : Container()),
      ),
    );
  }
}
