import 'package:arbpharm/ViewModels/demande/request_viewmodel.dart';
import 'package:arbpharm/Views/Component/back_app_bar.dart';
import 'package:arbpharm/Views/Component/custom_circular_progress_indicator.dart';
import 'package:arbpharm/Views/Component/request_item.dart';
import 'package:arbpharm/configs/const.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';

import '../../configs/size_config.dart';

class RequestHistory extends StatefulWidget {
  const RequestHistory({Key? key}) : super(key: key);

  @override
  State<RequestHistory> createState() => _RequestHistoryState();
}

class _RequestHistoryState extends State<RequestHistory> {
  ScrollController? _historyScrollController;

  @override
  void initState() {
    super.initState();
    _historyScrollController = ScrollController();
  }

  @override
  void dispose() {
    super.dispose();
    _historyScrollController!.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: PreferredSize(
        child: const CustomBackAppBar(title: 'Historique des demandes'),
        preferredSize:
            Size(SizeConfig.screenWidth, SizeConfig.screenHeight * 0.09),
      ),
      body: Consumer<RequestViewModel>(
        builder: (context, value, child) => FutureBuilder(
          future: value.getRequestHistory(context),
          builder: (context, snapShot) {
            _historyScrollController!.addListener(() {
              if (_historyScrollController!.position.maxScrollExtent ==
                      _historyScrollController!.position.pixels &&
                  value.hasNextPage) {
                value.getRequestHistory(context);
              }
            });
            return snapShot.connectionState == ConnectionState.waiting
                ? CustomCircuarProgressIdicator(color: elictricBlue)
                : SmartRefresher(
                    onRefresh: () => value.refresh(),
                    controller: value.refreshController,
                    child: Padding(
                      padding: EdgeInsets.symmetric(
                          horizontal: SizeConfig.screenWidth * 0.05),
                      child: ListView.builder(
                        itemCount: value.personalRequestsList.length,
                        itemBuilder: (context, index) =>
                            index == value.personalRequestsList.length - 1
                                ? value.hasNextPage
                                    ? Container(
                                        height: SizeConfig.screenHeight * 0.12,
                                        alignment: Alignment.topCenter,
                                        child: CustomCircuarProgressIdicator(
                                          color: elictricBlue,
                                        ),
                                      )
                                    : Container()
                                : RequestItem(
                                    request: value.personalRequestsList[index],
                                  ),
                      ),
                    ),
                  );
          },
        ),
      ),
    );
  }
}
