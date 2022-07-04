import 'package:arbpharm/Views/Component/app_bar.dart';
import 'package:flutter/material.dart';

import '../../configs/const.dart';
import '../../configs/size_config.dart';
import '../home/add_dialog_view.dart';

class BookmarkView extends StatelessWidget {
  const BookmarkView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: elictricBlue,
      appBar: PreferredSize(
        preferredSize:
            Size(SizeConfig.screenWidth, SizeConfig.screenHeight * 0.09),
        child: CustomAppBar(
          addPressed: () => displayAddDialog(context),
        ),
      ),
      body: Container(
        height: SizeConfig.screenHeight * 0.89,
        width: SizeConfig.screenWidth,
        margin: EdgeInsets.only(top: SizeConfig.screenHeight * 0.02),
        padding: EdgeInsets.only(top: SizeConfig.screenHeight * 0.035),
        decoration: BoxDecoration(
          color: cultured,
          borderRadius: BorderRadius.only(
            topLeft: Radius.circular(SizeConfig.screenHeight * 0.02),
            topRight: Radius.circular(SizeConfig.screenHeight * 0.02),
          ),
        ),
        child: const Center(child: Text('< Coming soon :) />')),
      ),
    );
  }

  void displayAddDialog(context) {
    showGeneralDialog(
      context: context,
      transitionBuilder: (context, a1, a2, widget) {
        return Transform.scale(
          scale: a1.value,
          child: Opacity(opacity: a1.value, child: widget),
        );
      },
      pageBuilder: (BuildContext context, Animation<double> animation,
          Animation<double> secondaryAnimation) {
        return const AddDialogView();
      },
    );
  }
}
