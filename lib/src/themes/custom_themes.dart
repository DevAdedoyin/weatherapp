import 'package:flutter/material.dart';
import 'package:weatherapp/src/constants/app_colors.dart';

// INPUT DECORATION DARK THEME
InputDecoration themeInputDecoration(String textHint, Widget icon,
        {bool? isPassword, bool? isCPassword, Widget? passwordIcon}) =>
    InputDecoration(
      hintText: textHint,
      // hintStyle:
      //     GoogleFonts.roboto(color: AppColors.inputFieldBG, fontSize: 10),
      // fillColor: AppColors.,
      filled: true,
      suffixIcon: isPassword == true || isCPassword == true
          ? passwordIcon
          : const SizedBox(),
      prefixIcon: icon,

      // iconColor: AppColors.accentColor,
      border: const OutlineInputBorder(

          borderRadius: BorderRadius.all(
            Radius.circular(10),
          ),
          borderSide: BorderSide.none),
      contentPadding: const EdgeInsets.symmetric(horizontal: 10, vertical: 1),
    );
