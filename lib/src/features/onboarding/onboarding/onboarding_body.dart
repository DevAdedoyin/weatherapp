import 'package:flutter/material.dart';
import 'package:weatherapp/src/common/gaps/sized_box.dart';

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
        height: size.height * 0.92,
        child: Column(children: [
          SizedBox(
              height: size.height * 0.6,
              child: Image.asset(
                image!,
                fit: BoxFit.contain,
              )),
          verticalGap(20.0),
          Text(title!, style: textTheme.titleMedium),
          verticalGap(8.0),
          Text(
            description!,
            textAlign: TextAlign.center,
            style: textTheme.bodyMedium,
          ),
        ]));
  }
}
