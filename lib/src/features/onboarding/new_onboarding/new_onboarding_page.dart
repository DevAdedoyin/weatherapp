import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:weatherapp/src/common/gaps/sized_box.dart';
import 'package:weatherapp/src/features/onboarding/new_onboarding/button_widget.dart';

class NewOnboardingPage extends StatelessWidget {
  final String title;
  final String image;
  final String description;

  const NewOnboardingPage(
      {required this.title,
      required this.image,
      required this.description,
      super.key});

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    TextTheme textTheme = Theme.of(context).textTheme;
    return SizedBox(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: [
          // Container(
          //   margin: EdgeInsets.only(right: 10),
          //   alignment: Alignment.centerRight,
          //   child: ButtonWidget(
          //     text: "Skip",
          //     backgroundColor: Colors.white,
          //     height: 30,
          //     width: 100,
          //     textColor: Colors.white30,
          //     onPress: () {},
          //   ),
          // ),
          verticalGap(30),
          Text(
            title,
            style: GoogleFonts.parisienne(fontSize: 35,
                fontWeight: FontWeight.bold, color: Colors.white),
          ),
          SizedBox(
            height: size.height * 0.5,
            child: Image.asset(
              image,
              fit: BoxFit.cover,
            ),
          ),
          SizedBox(
            width: size.width * 0.85,
            child: Text(
              description,
              style: TextStyle(color: Colors.white, fontWeight: FontWeight.w700),
              textAlign: TextAlign.center,
            ),
          )
        ],
      ),
    );
  }
}
