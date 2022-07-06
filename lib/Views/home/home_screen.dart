import 'package:arbpharm/ViewModels/home/home_viewmodel.dart';
import 'package:arbpharm/Views/Component/app_bar.dart';
import 'package:arbpharm/Views/Component/custom_circular_progress_indicator.dart';
import 'package:arbpharm/Views/Component/request_item.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';

import '../../configs/const.dart';
import '../../configs/size_config.dart';
import 'add_dialog_view.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> with TickerProviderStateMixin {
  TabController? _tabController;
  ScrollController? _requestScrollController;
  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: 2, vsync: this);
    _requestScrollController = ScrollController();
  }

  @override
  void dispose() {
    super.dispose();
    _tabController!.dispose();
    _requestScrollController!.dispose();
  }

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
        padding: EdgeInsets.only(
          top: SizeConfig.screenHeight * 0.035,
          left: SizeConfig.screenWidth * 0.05,
          right: SizeConfig.screenWidth * 0.05,
        ),
        decoration: BoxDecoration(
          color: cultured,
          borderRadius: BorderRadius.only(
            topLeft: Radius.circular(SizeConfig.screenHeight * 0.02),
            topRight: Radius.circular(SizeConfig.screenHeight * 0.02),
          ),
        ),
        child: DefaultTabController(
          length: 2,
          child: Column(
            children: [
              TabBar(
                controller: _tabController,
                onTap: (index) {
                  setState(() {
                    _tabController!.animateTo(index);
                  });
                },
                labelColor: elictricBlue,
                unselectedLabelColor: manatee,
                indicator: const BoxDecoration(),
                labelPadding: EdgeInsets.zero,
                labelStyle: GoogleFonts.montserrat(
                  fontWeight: FontWeight.w600,
                  fontSize: 2.2 * SizeConfig.blockSizeVertical,
                ),
                tabs: [
                  Tab(
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        const Text('Produits publiés'),
                        _tabController!.index == 0
                            ? Container(
                                height: 2.5,
                                width: SizeConfig.screenWidth * 0.33,
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(5),
                                  color: elictricBlue,
                                ),
                              )
                            : Container(
                                height: 2.5,
                              )
                      ],
                    ),
                  ),
                  Tab(
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        const Text('Demande de devis'),
                        _tabController!.index == 1
                            ? Container(
                                height: 2.5,
                                width: SizeConfig.screenWidth * 0.36,
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(5),
                                  color: elictricBlue,
                                ),
                              )
                            : Container(
                                height: 2.5,
                              )
                      ],
                    ),
                  ),
                ],
              ),
              Container(
                height: SizeConfig.screenHeight * 0.67,
                child: Consumer<HomeViewModel>(
                  builder: (context, value, child) {
                    _tabController!.addListener(() {
                      if (!_tabController!.indexIsChanging) return;
                      if (_tabController!.index == 0) {
                      } else if (_tabController!.index == 1) {
                        value.getRequests(context);
                      }
                    });
                    _requestScrollController!.addListener(() {
                      if (_requestScrollController!.position.maxScrollExtent ==
                              _requestScrollController!.position.pixels &&
                          value.requestHasNextPage) {
                        value.getRequests(context);
                      }
                      ;
                    });
                    return TabBarView(
                      controller: _tabController,
                      children: [
                        const Center(child: Text('< Coming soon :) />')),
                        value.working
                            ? Center(
                                child: CustomCircuarProgressIdicator(
                                  color: elictricBlue,
                                ),
                              )
                            : ListView.builder(
                                controller: _requestScrollController,
                                itemCount: value.requestList.length,
                                itemBuilder: (context, index) => index ==
                                        value.requestList.length - 1
                                    ? value.requestHasNextPage
                                        ? Container(
                                            height:
                                                SizeConfig.screenHeight * 0.12,
                                            alignment: Alignment.topCenter,
                                            child:
                                                CustomCircuarProgressIdicator(
                                              color: elictricBlue,
                                            ),
                                          )
                                        : Container()
                                    : RequestItem(
                                        viewMode: 1,
                                        request: value.requestList[index]),
                              ),
                      ],
                    );
                  },
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
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
