
import 'package:flutter/material.dart';

import '../constants/app_colors.dart';

class IconButtonThemes {
  IconButtonThemes._();

  static final lightModeIconButton = IconButtonThemeData(
      style: IconButton.styleFrom(
        elevation: 2,
        backgroundColor: AppColors.primaryColor,
        // padding: EdgeInsets.all(1),
        // iconSize: 1,
      ));
}