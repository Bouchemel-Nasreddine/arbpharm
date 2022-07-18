import 'package:arbpharm/Views/Component/about_us_element_view.dart';
import 'package:arbpharm/configs/const.dart';
import 'package:expandable/expandable.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:google_fonts/google_fonts.dart';

import '../../configs/size_config.dart';
import '../Component/back_app_bar.dart';
import '../Component/coming_soon_view.dart';

class AboutUsView extends StatelessWidget {
  const AboutUsView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        appBar: PreferredSize(
          preferredSize:
              Size(SizeConfig.screenWidth, SizeConfig.screenHeight * 0.09),
          child: CustomBackAppBar(
            title: "A propos de nous",
            titleColor: Colors.white,
            color: spaceCadet,
          ),
        ),
        body: SingleChildScrollView(
          child: Column(
            children: [
              Container(
                decoration: BoxDecoration(
                  color: spaceCadet,
                  borderRadius: BorderRadius.only(
                    bottomLeft: Radius.circular(SizeConfig.screenHeight * 0.05),
                    bottomRight:
                        Radius.circular(SizeConfig.screenHeight * 0.05),
                  ),
                ),
                height: SizeConfig.screenHeight * 0.2,
                alignment: Alignment.center,
                child: SvgPicture.asset(
                  "assets/arbpharm_logo.svg",
                  height: SizeConfig.screenHeight * 0.08,
                ),
              ),
              Container(
                padding: EdgeInsets.only(
                  left: SizeConfig.screenWidth * 0.05,
                  right: SizeConfig.screenWidth * 0.05,
                  top: SizeConfig.screenHeight * 0.06,
                ),
                child: Column(
                  children: [
                    const AboutUsElement(
                        title: 'Notre Application', description: ourApp),
                    SizedBox(
                      height: SizeConfig.screenHeight * 0.04,
                    ),
                    const AboutUsElement(
                        title: 'Notre Mission', description: ourMission),
                    SizedBox(
                      height: SizeConfig.screenHeight * 0.04,
                    ),
                    const AboutUsElement(
                        title: 'Notre Equipe ', description: ourTeam),
                    SizedBox(
                      height: SizeConfig.screenHeight * 0.04,
                    ),
                  ],
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
