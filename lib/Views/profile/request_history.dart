import 'package:arbpharm/Views/Component/back_app_bar.dart';
import 'package:flutter/material.dart';

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
    );
  }
}