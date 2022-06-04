import '../../configs/const.dart';
import '../../configs/size_config.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class CustomTextField extends StatelessWidget {
  final TextEditingController controller;
  final String label;
  final TextInputType type;
  final String? Function(String?)? validator;
  final bool isObscure;
  const CustomTextField({
    Key? key,
    required this.label,
    required this.controller,
    required this.type,
    this.validator,
    this.isObscure = false,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      controller: controller,
      keyboardType: type,
      style: GoogleFonts.montserrat(
        fontWeight: FontWeight.normal,
        fontSize: 1.7 * SizeConfig.blockSizeVertical,
        color: spaceCadet,
      ),
      decoration: InputDecoration(
        labelText: label,
        labelStyle: GoogleFonts.inter(
          fontWeight: FontWeight.normal,
          fontSize: SizeConfig.blockSizeVertical * 1.4,
        ),
        border: const OutlineInputBorder(),
        enabledBorder: OutlineInputBorder(
          borderSide: BorderSide(
            color: brightGrey,
          ),
        ),
        focusedBorder: OutlineInputBorder(
          borderSide: BorderSide(
            color: metalicSeaweed,
          ),
        ),
      ),
      validator: validator,
      obscureText: isObscure,
    );
  }
}
