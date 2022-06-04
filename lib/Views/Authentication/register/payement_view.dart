import 'package:arbpharm/ViewModels/Authentication/register_viewmodel.dart';
import 'package:arbpharm/Views/Component/upload_file_field.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';

import '../../../configs/const.dart';
import '../../../configs/size_config.dart';
import '../../Component/button_widget.dart';

class PayementInformationView extends StatelessWidget {
  const PayementInformationView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Consumer<RegisterViewModel>(
      builder: (context, value, child) => Scaffold(
        backgroundColor: seaBlue,
        body: SafeArea(
          child: Center(
            child: Container(
              margin: EdgeInsets.symmetric(
                  vertical: SizeConfig.screenHeight * 0.05),
              height: SizeConfig.screenHeight * 0.85,
              width: SizeConfig.screenWidth,
              padding: EdgeInsets.symmetric(
                horizontal: SizeConfig.screenWidth * 0.1,
                vertical: SizeConfig.screenHeight * 0.04,
              ),
              decoration: BoxDecoration(
                borderRadius:
                    BorderRadius.circular(SizeConfig.screenWidth * 0.1),
                color: Colors.white,
              ),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'Inscription',
                    style: GoogleFonts.montserrat(
                        fontWeight: FontWeight.bold,
                        color: spaceCadet,
                        fontSize: SizeConfig.blockSizeVertical * 3.6),
                  ),
                  Text(
                    ccpInfo,
                    style: GoogleFonts.montserrat(
                      fontWeight: FontWeight.w600,
                      fontSize: 1.5 * SizeConfig.blockSizeVertical,
                      color: spaceCadet,
                    ),
                  ),
                  Text(
                    proofs,
                    style: GoogleFonts.montserrat(
                      fontWeight: FontWeight.w600,
                      fontSize: 1.5 * SizeConfig.blockSizeVertical,
                      color: spaceCadet,
                    ),
                  ),
                  Column(
                    children: [
                      CustomUploadFileField(
                        size: Size(
                          SizeConfig.screenWidth * 0.85,
                          SizeConfig.screenHeight * 0.075,
                        ),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(2),
                          side: BorderSide(
                            width: 0.8,
                            color: brightGrey,
                          ),
                        ),
                        uploadPhoto: () => value.getProofsPics(context),
                      ),
                      SizedBox(
                        height: SizeConfig.screenHeight * 0.01,
                      ),
                      SizedBox(
                        height: SizeConfig.screenHeight * 0.12,
                        child: ListView.builder(
                          scrollDirection: Axis.horizontal,
                          itemCount: value.paymentProofs.isEmpty
                              ? 0
                              : value.paymentProofs.length,
                          itemBuilder: (context, index) => Row(
                            children: [
                              Container(
                                width: SizeConfig.screenWidth * 0.185,
                                clipBehavior: Clip.antiAlias,
                                decoration: BoxDecoration(
                                  shape: BoxShape.rectangle,
                                  borderRadius: BorderRadius.circular(2),
                                ),
                                child: value.paymentProofs.isNotEmpty
                                    ? Stack(
                                        alignment: Alignment.topRight,
                                        children: [
                                          Image.file(
                                            value.paymentProofs[index]!,
                                            height:
                                                SizeConfig.screenWidth * 0.185,
                                            width:
                                                SizeConfig.screenWidth * 0.185,
                                            fit: BoxFit.cover,
                                          ),
                                          Positioned(
                                            top:
                                                SizeConfig.screenHeight * 0.002,
                                            right:
                                                SizeConfig.screenHeight * 0.002,
                                            child: InkWell(
                                              onTap: () =>
                                                  value.removeProof(index),
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
                                width: SizeConfig.screenWidth * 0.02,
                              )
                            ],
                          ),
                        ),
                      ),
                      // Container(
                      //   width: SizeConfig.screenWidth * 0.185,
                      //   clipBehavior: Clip.antiAlias,
                      //   decoration: BoxDecoration(
                      //     shape: BoxShape.rectangle,
                      //     borderRadius: BorderRadius.circular(2),
                      //   ),
                      //   child: value.paymentProofs.length > 1
                      //       ? Stack(
                      //           alignment: Alignment.topRight,
                      //           children: [
                      //             Image.file(
                      //               value.paymentProofs[1]!,
                      //               height: SizeConfig.screenWidth * 0.185,
                      //               width: SizeConfig.screenWidth * 0.185,
                      //               fit: BoxFit.cover,
                      //             ),
                      //             Positioned(
                      //               top: SizeConfig.screenHeight * 0.002,
                      //               right: SizeConfig.screenHeight * 0.002,
                      //               child: InkWell(
                      //                 onTap: () => value.removeProof(3),
                      //                 child: const Icon(
                      //                   Icons.cancel,
                      //                   color: Colors.red,
                      //                 ),
                      //               ),
                      //             ),
                      //           ],
                      //         )
                      //       : Container(),
                      // ),
                      // Container(
                      //   width: SizeConfig.screenWidth * 0.185,
                      //   clipBehavior: Clip.antiAlias,
                      //   decoration: BoxDecoration(
                      //     shape: BoxShape.rectangle,
                      //     borderRadius: BorderRadius.circular(2),
                      //   ),
                      //   child: value.paymentProofs.length > 2
                      //       ? Stack(
                      //           alignment: Alignment.topRight,
                      //           children: [
                      //             Image.file(
                      //               value.paymentProofs[2]!,
                      //               height: SizeConfig.screenWidth * 0.185,
                      //               width: SizeConfig.screenWidth * 0.185,
                      //               fit: BoxFit.cover,
                      //             ),
                      //             Positioned(
                      //               top: SizeConfig.screenHeight * 0.002,
                      //               right: SizeConfig.screenHeight * 0.002,
                      //               child: InkWell(
                      //                 onTap: () => value.removeProof(2),
                      //                 child: const Icon(
                      //                   Icons.cancel,
                      //                   color: Colors.red,
                      //                 ),
                      //               ),
                      //             ),
                      //           ],
                      //         )
                      //       : Container(),
                      // ),
                      // Container(
                      //   width: SizeConfig.screenWidth * 0.185,
                      //   clipBehavior: Clip.antiAlias,
                      //   decoration: BoxDecoration(
                      //     shape: BoxShape.rectangle,
                      //     borderRadius: BorderRadius.circular(2),
                      //   ),
                      //   child: value.paymentProofs.length > 3
                      //       ? Stack(
                      //           alignment: Alignment.topRight,
                      //           children: [
                      //             Image.file(
                      //               value.paymentProofs[3]!,
                      //               height: SizeConfig.screenWidth * 0.185,
                      //               width: SizeConfig.screenWidth * 0.185,
                      //               fit: BoxFit.cover,
                      //             ),
                      //             Positioned(
                      //               top: SizeConfig.screenHeight * 0.002,
                      //               right: SizeConfig.screenHeight * 0.002,
                      //               child: InkWell(
                      //                 onTap: () => value.removeProof(3),
                      //                 child: const Icon(
                      //                   Icons.cancel,
                      //                   color: Colors.red,
                      //                 ),
                      //               ),
                      //             ),
                      //           ],
                      //         )
                      //       : Container(),
                      // ),
                    ],
                  ),
                  CustomButton(
                    text: 'Envoyer',
                    onPressed: () {
                      if (value.paymentProofs.length == 4) {
                        value.register(context);
                      }
                    },
                    working: value.working,
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  final String ccpInfo =
      'Merci de verser la somme d\'inscription à \n0023816621    58 \nRAZIBAOUENE Asma \nBoumerdes \net appeler le 0795470066';
  final String proofs =
      'Envoyer la photo de \n*reçue de payment \n*RC \n*Les codes d\'activité \n*carte professionelle';
}
