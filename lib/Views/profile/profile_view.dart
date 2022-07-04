import 'package:arbpharm/ViewModels/profile/profile_viewmodel.dart';
import 'package:arbpharm/Views/Component/coming_soon_view.dart';
import 'package:arbpharm/Views/Component/custom_circular_progress_indicator.dart';
import 'package:arbpharm/Views/Component/custom_icon_button.dart';
import 'package:arbpharm/Views/Component/profile_row.dart';
import 'package:arbpharm/Views/profile/profile%20settings/profile_settings.dart';
import 'package:arbpharm/Views/profile/request_history.dart';
import 'package:arbpharm/configs/const.dart';
import 'package:arbpharm/configs/generale_vars.dart';
import 'package:arbpharm/configs/size_config.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';

class ProfileView extends StatelessWidget {
  const ProfileView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        padding: EdgeInsets.only(
          top: MediaQuery.of(context).viewPadding.top +
              SizeConfig.screenHeight * 0.02,
        ),
        color: seaBlue,
        child: Consumer<ProfileViewModel>(
          builder: (context, value, child) => FutureBuilder(
            future: value.getProfileDetails(),
            builder: (context, snapShot) => snapShot.connectionState ==
                    ConnectionState.waiting
                ? const CustomCircuarProgressIdicator()
                : SmartRefresher(
                    controller: value.refreshController,
                    onRefresh: () => value.refresh(),
                    child: SingleChildScrollView(
                      child: Column(
                        children: [
                          Padding(
                            padding: EdgeInsets.only(
                              left: SizeConfig.screenWidth * 0.05,
                              right: SizeConfig.screenWidth * 0.05,
                            ),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text(
                                      userConst.profileName,
                                      style: GoogleFonts.montserrat(
                                        fontWeight: FontWeight.w600,
                                        color: Colors.white,
                                        fontSize:
                                            2.7 * SizeConfig.blockSizeVertical,
                                      ),
                                    ),
                                    !userConst.isTypeActivated
                                        ? Text(
                                            "*votre compte n'est pas encore activé",
                                            style: GoogleFonts.montserrat(
                                              fontWeight: FontWeight.w400,
                                              color:
                                                  Theme.of(context).errorColor,
                                              fontSize: 3 *
                                                  SizeConfig
                                                      .blockSizeHorizontal,
                                            ),
                                          )
                                        : userConst.type != null
                                            ? Container(
                                                decoration: const BoxDecoration(
                                                  shape: BoxShape.circle,
                                                  color: Colors.white,
                                                ),
                                                clipBehavior: Clip.antiAlias,
                                                padding: EdgeInsets.all(
                                                    SizeConfig.screenHeight *
                                                        0.005),
                                                child: Text(
                                                  userConst.type!,
                                                  style: GoogleFonts.poppins(
                                                    fontWeight: FontWeight.w600,
                                                    fontSize: SizeConfig
                                                            .blockSizeVertical *
                                                        2.8,
                                                    color: Colors.red,
                                                  ),
                                                ),
                                              )
                                            : Container(),
                                  ],
                                ),
                                CustomIconButton(
                                  icon: SvgPicture.asset(
                                    "assets/Notification.svg",
                                    color: Colors.white,
                                  ),
                                  onPressed: () {
                                    Navigator.push(
                                      context,
                                      MaterialPageRoute(
                                          builder: (context) =>
                                              const ComingSoonView()),
                                    );
                                  },
                                ),
                              ],
                            ),
                          ),
                          SizedBox(
                            width: SizeConfig.screenWidth,
                            height: userConst.isTypeActivated
                                ? SizeConfig.screenHeight * 0.8
                                : SizeConfig.screenHeight * 0.865,
                            child: Stack(
                              alignment: Alignment.topCenter,
                              children: [
                                Positioned(
                                  top: SizeConfig.screenHeight * 0.075,
                                  child: Container(
                                    width: SizeConfig.screenWidth,
                                    height: userConst.isTypeActivated
                                        ? SizeConfig.screenHeight * 0.75
                                        : SizeConfig.screenHeight * 0.865,
                                    decoration: BoxDecoration(
                                      shape: BoxShape.rectangle,
                                      borderRadius: BorderRadius.only(
                                        topLeft: Radius.circular(
                                            SizeConfig.screenHeight * 0.05),
                                        topRight: Radius.circular(
                                            SizeConfig.screenHeight * 0.05),
                                      ),
                                      color: Colors.white,
                                    ),
                                    clipBehavior: Clip.antiAlias,
                                    padding: EdgeInsets.only(
                                      top: SizeConfig.screenHeight * 0.12,
                                      right: SizeConfig.screenWidth * 0.05,
                                      left: SizeConfig.screenWidth * 0.05,
                                    ),
                                    child: Column(
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceEvenly,
                                      children: [
                                        CustomProfileRow(
                                          icon: "assets/profile.svg",
                                          title: 'Profil',
                                          onPressed: () => value.goToPage(
                                              context, const ProfileSettings()),
                                        ),
                                        CustomProfileRow(
                                          icon: "assets/gift.svg",
                                          title: 'Historique des demandes',
                                          onPressed: () => value.goToPage(
                                              context, const RequestHistory()),
                                        ),
                                        CustomProfileRow(
                                          icon: "assets/staff.svg",
                                          title: 'Contactez-nous',
                                          onPressed: () => value.goToPage(
                                              context, const ComingSoonView()),
                                        ),
                                        CustomProfileRow(
                                          icon: "assets/info.svg",
                                          title: 'A Propos',
                                          onPressed: () => value.goToPage(
                                              context, const ComingSoonView()),
                                        ),
                                        Container(
                                          height: SizeConfig.screenHeight * 0.1,
                                          alignment: Alignment.center,
                                          child: Material(
                                            color: Colors.transparent,
                                            child: InkWell(
                                              onTap: () =>
                                                  value.logout(context),
                                              child: SizedBox(
                                                width: SizeConfig.screenWidth *
                                                    0.265,
                                                child: Row(
                                                  mainAxisAlignment:
                                                      MainAxisAlignment
                                                          .spaceBetween,
                                                  crossAxisAlignment:
                                                      CrossAxisAlignment.center,
                                                  children: [
                                                    SvgPicture.asset(
                                                      "assets/logout.svg",
                                                      height: SizeConfig
                                                              .screenHeight *
                                                          0.025,
                                                    ),
                                                    Text(
                                                      'déconnexion',
                                                      style: GoogleFonts
                                                          .montserrat(
                                                        fontWeight:
                                                            FontWeight.w500,
                                                        color: elictricBlue,
                                                        fontSize: 3 *
                                                            SizeConfig
                                                                .blockSizeHorizontal,
                                                      ),
                                                    )
                                                  ],
                                                ),
                                              ),
                                            ),
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                ),
                                Stack(
                                  alignment: Alignment.center,
                                  children: [
                                    Container(
                                      decoration: const BoxDecoration(
                                        shape: BoxShape.circle,
                                        color: Colors.white,
                                      ),
                                      clipBehavior: Clip.antiAlias,
                                      height: SizeConfig.screenHeight * 0.16,
                                      width: SizeConfig.screenHeight * 0.16,
                                    ),
                                    Container(
                                      decoration: const BoxDecoration(
                                        shape: BoxShape.circle,
                                        color: Colors.white,
                                      ),
                                      clipBehavior: Clip.antiAlias,
                                      child: value.picture != null
                                          ? SizedBox(
                                              height: SizeConfig.screenHeight *
                                                  0.15,
                                              width: SizeConfig.screenHeight *
                                                  0.15,
                                              child: Stack(
                                                children: [
                                                  Image.file(
                                                    value.picture!,
                                                    height: SizeConfig
                                                            .screenHeight *
                                                        0.15,
                                                    width: SizeConfig
                                                            .screenHeight *
                                                        0.15,
                                                    fit: BoxFit.cover,
                                                  ),
                                                  value.pictureWorking
                                                      ? Opacity(
                                                          opacity: 0.4,
                                                          child: Container(
                                                              color:
                                                                  Colors.white),
                                                        )
                                                      : Container(),
                                                  value.pictureWorking
                                                      ? Center(
                                                          child:
                                                              CircularProgressIndicator(
                                                            color: elictricBlue,
                                                            strokeWidth: 0.7,
                                                          ),
                                                        )
                                                      : Container()
                                                ],
                                              ),
                                            )
                                          : CachedNetworkImage(
                                              imageUrl: userConst
                                                      .getProfile.profilePic ??
                                                  "",
                                              fit: BoxFit.cover,
                                              errorWidget: (context, str,
                                                      dyn) =>
                                                  SvgPicture.asset(
                                                      "assets/arbpharm_logo.svg"),
                                              progressIndicatorBuilder:
                                                  (context, str, progress) =>
                                                      SizedBox(
                                                height:
                                                    SizeConfig.screenHeight *
                                                        0.15,
                                                width: SizeConfig.screenHeight *
                                                    0.15,
                                                child:
                                                    const LinearProgressIndicator(),
                                              ),
                                              height: SizeConfig.screenHeight *
                                                  0.15,
                                              width: SizeConfig.screenHeight *
                                                  0.15,
                                            ),
                                    ),
                                  ],
                                ),
                                Positioned(
                                  top: SizeConfig.screenHeight * 0.1,
                                  right: SizeConfig.screenWidth * 0.35,
                                  child: CustomIconButton(
                                    height: SizeConfig.screenHeight * 0.04,
                                    width: SizeConfig.screenHeight * 0.04,
                                    backColor: elictricBlue,
                                    icon: SvgPicture.asset("assets/pencil.svg"),
                                    onPressed: () =>
                                        value.storeProfilePic(context),
                                  ),
                                ),
                              ],
                            ),
                          )
                        ],
                      ),
                    ),
                  ),
          ),
        ),
      ),
    );
  }
}
