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
    return SizedBox(
        child: Column(children: [
      Image.asset(image!),
      verticalGap(4.0),
      Text(title!),
      verticalGap(4.0),
      Text(description!),
    ]));
  }
}
