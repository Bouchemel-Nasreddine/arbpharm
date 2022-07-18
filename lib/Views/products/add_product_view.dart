import 'package:arbpharm/ViewModels/Products/add_product_viewmodel.dart';
import 'package:arbpharm/Views/Component/button_widget.dart';
import 'package:arbpharm/Views/Component/custom_icon_button.dart';
import 'package:arbpharm/configs/const.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';

import '../../configs/size_config.dart';
import '../Component/text_field_widget.dart';
import '../Component/upload_file_field.dart';

class AddProductView extends StatefulWidget {
  const AddProductView({Key? key}) : super(key: key);

  @override
  State<AddProductView> createState() => _AddProductViewState();
}

class _AddProductViewState extends State<AddProductView> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: PreferredSize(
        child: AppBar(
          backgroundColor: Colors.transparent,
          elevation: 0,
          leading: CustomIconButton(
            icon: Icon(
              Icons.arrow_back_ios_new_rounded,
              color: spaceCadet,
            ),
            onPressed: () => Navigator.pop(context),
          ),
          centerTitle: true,
          title: Text(
            'Ajouter un produit',
            style: GoogleFonts.inter(
              fontWeight: FontWeight.w600,
              fontSize: 2.3 * SizeConfig.blockSizeVertical,
              color: spaceCadet,
            ),
          ),
        ),
        preferredSize:
            Size(SizeConfig.screenWidth, SizeConfig.screenHeight * 0.09),
      ),
      body: SingleChildScrollView(
        child: Container(
          height: SizeConfig.screenHeight * 0.9,
          padding:
              EdgeInsets.symmetric(horizontal: SizeConfig.screenWidth * 0.05),
          child: Consumer<AddProductViewModel>(
            builder: (context, value, child) => Column(
              children: [
                CustomUploadFileField(
                  size: Size(
                    SizeConfig.screenWidth * 0.9,
                    SizeConfig.screenHeight * 0.2,
                  ),
                  shape: RoundedRectangleBorder(
                    borderRadius:
                        BorderRadius.circular(SizeConfig.screenHeight * 0.007),
                    side: BorderSide(
                      width: 0.9,
                      color: metalicSeaweed,
                    ),
                  ),
                  uploadPhoto: () => value.getProductPics(context),
                ),
                SizedBox(
                  height: SizeConfig.screenHeight * 0.03,
                  child: Text(
                    '*2 fichiers au minimum requis, 4 au maximum',
                    style: GoogleFonts.inter(
                      fontSize: 1.4 * SizeConfig.blockSizeVertical,
                      color: manatee,
                      fontWeight: FontWeight.w400,
                    ),
                  ),
                ),
                Container(
                  height: SizeConfig.screenHeight * 0.12,
                  child: ListView.builder(
                    scrollDirection: Axis.horizontal,
                    itemCount: value.productPics.isEmpty
                        ? 0
                        : value.productPics.length,
                    itemBuilder: (context, index) => Row(
                      children: [
                        Container(
                          width: SizeConfig.screenWidth * 0.185,
                          clipBehavior: Clip.antiAlias,
                          decoration: BoxDecoration(
                            shape: BoxShape.rectangle,
                            borderRadius: BorderRadius.circular(2),
                          ),
                          child: value.productPics.isNotEmpty
                              ? Stack(
                                  alignment: Alignment.topRight,
                                  children: [
                                    Image.file(
                                      value.productPics[index]!,
                                      height: SizeConfig.screenWidth * 0.185,
                                      width: SizeConfig.screenWidth * 0.185,
                                      fit: BoxFit.cover,
                                    ),
                                    Positioned(
                                      top: SizeConfig.screenHeight * 0.002,
                                      right: SizeConfig.screenHeight * 0.002,
                                      child: InkWell(
                                        onTap: () => value.removePics(index),
                                        child: const Icon(
                                          Icons.cancel,
                                          color: Colors.red,
                                        ),
                                      ),
                                    ),
                                  ],
                                )
                              : Container(),
                        ),
                        SizedBox(
                          width: SizeConfig.screenWidth * 0.05,
                        )
                      ],
                    ),
                  ),
                ),
                SizedBox(
                  height: SizeConfig.screenHeight * 0.01,
                ),
                CustomTextField(
                  controller: value.descriptionController,
                  label: "description",
                  type: TextInputType.text,
                  lines: 8,
                ),
                SizedBox(
                  height: SizeConfig.screenHeight * 0.1,
                ),
                // CustomUploadFileField(
                //   size: Size(
                //     SizeConfig.screenWidth * 0.9,
                //     SizeConfig.screenHeight * 0.12,
                //   ),
                //   shape: RoundedRectangleBorder(
                //     borderRadius:
                //         BorderRadius.circular(SizeConfig.screenHeight * 0.007),
                //     side: BorderSide(
                //       width: 0.9,
                //       color: metalicSeaweed,
                //     ),
                //   ),
                //   uploadPhoto: () => value.getProductPics(context),
                // ),
                CustomButton(
                  text: 'Publier',
                  onPressed: () => value.postProduct(context),
                  working: value.working,
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
