import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:google_fonts/google_fonts.dart';

import '../../configs/size_config.dart';

class CustomUploadFileField extends StatelessWidget {
  final Size size;
  final OutlinedBorder? shape;
  final String? label;
  File? file;
  final Future<void> Function() uploadPhoto;
  CustomUploadFileField({
    Key? key,
    required this.size,
    this.shape,
    this.label,
    this.file = null,
    required this.uploadPhoto,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      onPressed: () => uploadPhoto(),
      child: label == null
          ? file == null
              ? SvgPicture.asset("assets/download.svg")
              : Container(
                  clipBehavior: Clip.antiAlias,
                  decoration: const BoxDecoration(
                    shape: BoxShape.circle,
                  ),
                  child: Image.file(
                    file!,
                    height: size.height,
                    width: size.width,
                    fit: BoxFit.cover,
                  ),
                )
          : Column(
              children: [
                SizedBox(
                  height: SizeConfig.screenHeight * 0.005,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    Text(
                      label!,
                      style: GoogleFonts.inter(
                        fontWeight: FontWeight.normal,
                        color: Theme.of(context).hintColor,
                        fontSize: SizeConfig.blockSizeVertical * 1.2,
                      ),
                    ),
                  ],
                ),
                file == null
                    ? SvgPicture.asset("assets/download.svg")
                    : Container(
                        clipBehavior: Clip.antiAlias,
                        decoration: BoxDecoration(
                          shape: BoxShape.rectangle,
                          borderRadius: BorderRadius.circular(
                              SizeConfig.screenHeight * 0.01),
                        ),
                        child: Image.file(
                          file!,
                          height: size.height * 0.72,
                          width: size.height * 0.72,
                          fit: BoxFit.cover,
                        ),
                      ),
              ],
            ),
      style: ElevatedButton.styleFrom(
        elevation: 0,
        primary: Colors.transparent,
        shape: shape,
        fixedSize: size,
      ),
    );
  }
}
