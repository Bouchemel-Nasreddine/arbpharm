import 'package:arbpharm/Views/profile/profile%20settings/change_password_view.dart';
import 'package:arbpharm/Views/profile/profile%20settings/update_profile_info_view.dart';
import 'package:flutter/material.dart';

import '../../../configs/size_config.dart';
import '../../Component/back_app_bar.dart';
import '../../Component/profile_row.dart';

class ProfileSettings extends StatelessWidget {
  const ProfileSettings({Key? key}) : super(key: key);

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
      body: Container(
        padding: EdgeInsets.symmetric(
          horizontal: SizeConfig.screenWidth * 0.05,
        ),
        height: SizeConfig.screenHeight * 0.3,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            CustomProfileRow(
              icon: "assets/profile.svg",
              title: 'Editer les informations du compte',
              onPressed: () => goToPage(context, UpdateProfileView()),
            ),
            CustomProfileRow(
              icon: "assets/lock.svg",
              title: 'Changer le mot de passe',
              onPressed: () => goToPage(context, ChangePasswordView()),
            ),
          ],
        ),
      ),
    );
  }
}
