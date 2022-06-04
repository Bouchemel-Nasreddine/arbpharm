import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import '../../configs/const.dart';
import '../../configs/size_config.dart';

class CustomButton extends StatelessWidget {
  final void Function()? onPressed;
  final String text;
  final Size? size;
  final bool working;
  const CustomButton(
      {Key? key,
      required this.text,
      required this.onPressed,
      this.size,
      this.working = false})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      onPressed: onPressed,
      child: working
          ? Center(
              child: CircularProgressIndicator(
              color: elictricBlue,
              strokeWidth: 1,
            ))
          : Text(
              text,
              style: GoogleFonts.inter(
                fontWeight: FontWeight.w600,
                fontSize: 2 * SizeConfig.blockSizeVertical,
                color: Colors.white,
              ),
            ),
      style: ElevatedButton.styleFrom(
        primary: working ? cultured : metalicSeaweed,
        elevation: 0,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(SizeConfig.screenHeight * 0.2),
        ),
        fixedSize: Size(
          SizeConfig.screenWidth * 0.85,
          SizeConfig.screenHeight * 0.075,
        ),
      ),
    );
  }
}
