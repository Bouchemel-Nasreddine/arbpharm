import 'package:flutter/material.dart';

import '../../configs/size_config.dart';
import '../Component/back_app_bar.dart';

class ProfileSettings extends StatelessWidget {
  const ProfileSettings({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: PreferredSize(
        preferredSize:
            Size(SizeConfig.screenWidth, SizeConfig.screenHeight * 0.09),
        child: const CustomBackAppBar(
          title: 'Profil',
        ),
      ),
    );
  }
}
