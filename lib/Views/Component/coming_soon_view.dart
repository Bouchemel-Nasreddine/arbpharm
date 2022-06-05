import 'package:arbpharm/Views/Component/back_app_bar.dart';
import 'package:flutter/material.dart';

import '../../configs/size_config.dart';

class ComingSoonView extends StatelessWidget {
  const ComingSoonView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: PreferredSize(
        preferredSize:
            Size(SizeConfig.screenWidth, SizeConfig.screenHeight * 0.09),
        child: const CustomBackAppBar(
          title: "",
        ),
      ),
      body: const Center(child: Text('< Coming soon :) />')),
    );
  }
}
