import 'package:arbpharm/Views/bookmark/bookmark_view.dart';
import 'package:arbpharm/Views/home/home_screen.dart';
import 'package:arbpharm/Views/profile/profile_view.dart';
import 'package:arbpharm/configs/size_config.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:persistent_bottom_nav_bar/persistent-tab-view.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../configs/const.dart';
import 'package:flutter/material.dart';

class GeneraleHomeView extends StatefulWidget {
  const GeneraleHomeView({Key? key}) : super(key: key);

  @override
  State<GeneraleHomeView> createState() => _GeneraleHomeState();
}

class _GeneraleHomeState extends State<GeneraleHomeView> {
  late PersistentTabController _tabsController;
  List<Widget> _buildScreens() {
    return [
      const HomeScreen(),
      const Center(child: Text('< Coming soon :) />')),
      const BookmarkView(),
      const ProfileView(),
    ];
  }

  List<PersistentBottomNavBarItem> _barIcon() {
    return [
      PersistentBottomNavBarItem(
        icon: SvgPicture.asset(
          "assets/home.svg",
          color: elictricBlue,
          height: SizeConfig.screenHeight * 0.03,
        ),
        inactiveIcon: SvgPicture.asset(
          "assets/home.svg",
          color: manatee,
          height: SizeConfig.screenHeight * 0.03,
        ),
      ),
      PersistentBottomNavBarItem(
        icon: SvgPicture.asset(
          "assets/products.svg",
          color: elictricBlue,
          height: SizeConfig.screenHeight * 0.03,
        ),
        inactiveIcon: SvgPicture.asset(
          "assets/products.svg",
          color: manatee,
          height: SizeConfig.screenHeight * 0.03,
        ),
      ),
      PersistentBottomNavBarItem(
        icon: SvgPicture.asset(
          "assets/bookmark.svg",
          color: elictricBlue,
          height: SizeConfig.screenHeight * 0.03,
        ),
        inactiveIcon: SvgPicture.asset(
          "assets/bookmark.svg",
          color: manatee,
          height: SizeConfig.screenHeight * 0.03,
        ),
      ),
      PersistentBottomNavBarItem(
        icon: SvgPicture.asset(
          "assets/person.svg",
          color: elictricBlue,
          height: SizeConfig.screenHeight * 0.03,
        ),
        inactiveIcon: SvgPicture.asset(
          "assets/person.svg",
          color: manatee,
          height: SizeConfig.screenHeight * 0.03,
        ),
      ),
    ];
  }

  @override
  void initState() {
    _tabsController = PersistentTabController();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    SizeConfig().init(context);
    return Scaffold(
      body: PersistentTabView(
        context,
        backgroundColor: Colors.white,
        screens: _buildScreens(),
        controller: _tabsController,
        navBarStyle: NavBarStyle.style12,
        items: _barIcon(),
        decoration: NavBarDecoration(
          boxShadow: [
            const BoxShadow(
              color: Colors.black26,
              spreadRadius: 2,
              blurRadius: 5,
              blurStyle: BlurStyle.normal,
              offset: Offset(3, 0),
            )
          ],
          borderRadius: BorderRadius.only(
            topLeft: Radius.circular(SizeConfig.screenHeight * 0.03),
            topRight: Radius.circular(SizeConfig.screenHeight * 0.03),
          ),
        ),
      ),
    );
  }
}
