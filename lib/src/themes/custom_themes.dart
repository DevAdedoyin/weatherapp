import 'package:flutter/material.dart';
import 'package:weatherapp/src/constants/app_colors.dart';

// INPUT DECORATION DARK THEME
InputDecoration darkThemeInputDecoration(String textHint, Widget icon) =>
    InputDecoration(
      hintText: textHint,
      // hintStyle:
      //     GoogleFonts.roboto(color: AppColors.inputFieldBG, fontSize: 10),
      fillColor: AppColors.inputBackGroundDT,
      filled: true,
      prefixIcon: icon,
      border: const OutlineInputBorder(
          borderRadius: BorderRadius.all(
            Radius.circular(10),
          ),
          borderSide: BorderSide.none),
      contentPadding: const EdgeInsets.symmetric(horizontal: 10, vertical: 1),
    );
