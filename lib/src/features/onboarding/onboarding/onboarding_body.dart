import 'package:flutter/material.dart';
import 'package:weatherapp/src/common/gaps/sized_box.dart';
import 'package:weatherapp/src/constants/app_colors.dart';

class OnboardingBodyWidget extends StatelessWidget {
  final String? image;
  final String? description;
  final String? title;
  const OnboardingBodyWidget(
      {super.key, this.description, this.image, this.title});

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    TextTheme textTheme = Theme.of(context).textTheme;
    return SizedBox(
        // color: Colors.white,
        // height: size.height * 0.90,
        child: Column(children: [
      Container(
        color: AppColors.cardBgColor,
        height: size.height < 650 ? size.height * 0.45 : size.height * 0.50,
        child: Card(
          color: AppColors.scaffoldBgColor,
          elevation: 5,
          child: Image.asset(
            image!,
            fit: BoxFit.contain,
          ),
        ),
      ),
      verticalGap(size.height < 650 ? size.height * 0.10 : size.height * 0.15),
      Text(title!, style: textTheme.titleMedium),
      verticalGap(size.height * 0.01),
      Text(
        description!,
        textAlign: TextAlign.center,
        style: textTheme.displaySmall,
      ),
    ]));
  }
}
