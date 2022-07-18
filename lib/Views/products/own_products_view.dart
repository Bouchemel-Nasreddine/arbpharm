import 'package:arbpharm/Views/Component/empty_state.dart';
import 'package:arbpharm/Views/Component/product_item.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';

import '../../ViewModels/own products/own_products_viewmodel.dart';
import '../../configs/const.dart';
import '../../configs/size_config.dart';
import '../Component/app_bar.dart';
import '../Component/custom_circular_progress_indicator.dart';
import '../home/home_screen.dart';

class OwnProductsView extends StatefulWidget {
  const OwnProductsView({Key? key}) : super(key: key);

  @override
  State<OwnProductsView> createState() => _OwnProductsViewState();
}

class _OwnProductsViewState extends State<OwnProductsView> {
  TabController? _tabController;
  ScrollController? _requestScrollController;
  ScrollController? _productsScrollController;
  @override
  void initState() {
    super.initState();
    _productsScrollController = ScrollController();
  }

  @override
  void dispose() {
    super.dispose();
    _productsScrollController!.dispose();
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
        child: Container(
          child: Column(
            children: [
              Text(
                'Mes Produits',
                style: GoogleFonts.poppins(
                  fontWeight: FontWeight.w500,
                  fontSize: SizeConfig.blockSizeVertical * 2.5,
                  color: spaceCadet,
                ),
              ),
              Container(
                padding: EdgeInsets.only(
                  top: SizeConfig.screenHeight * 0.02,
                ),
                height: SizeConfig.screenHeight * 0.72,
                child: Consumer<OwnProductsViewModel>(
                    builder: (context, value, child) {
                  if (value.productsList.isEmpty) {
                    value.getProducts(context);
                  }
                  return value.working
                      ? const CustomCircuarProgressIdicator()
                      : value.productsList.isEmpty
                          ? EmptyStateView()
                          : GridView.builder(
                              gridDelegate:
                                  SliverGridDelegateWithFixedCrossAxisCount(
                                crossAxisCount: 2,
                                mainAxisSpacing:
                                    SizeConfig.screenHeight * 0.025,
                                crossAxisSpacing:
                                    SizeConfig.screenHeight * 0.04,
                                childAspectRatio:
                                    (SizeConfig.screenWidth * 0.413) /
                                        (SizeConfig.screenHeight * 0.35),
                              ),
                              controller: _productsScrollController,
                              itemCount: value.productsList.length,
                              itemBuilder: (context, index) => ProductItem(
                                product: value.productsList[index],
                                showFavorite: false,
                              ),
                            );
                }),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
