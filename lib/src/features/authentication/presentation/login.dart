import "package:flutter/material.dart";
import "package:google_fonts/google_fonts.dart";
import "package:weatherapp/src/common/gaps/sized_box.dart";
import "package:weatherapp/src/constants/app_colors.dart";
import "package:weatherapp/src/features/authentication/presentation/login_form.dart";
import "package:weatherapp/src/features/authentication/presentation/third_party_auth.dart";

class LoginScreen extends StatelessWidget {
  const LoginScreen({super.key});

  @override
  Widget build(BuildContext context) {
    // Size size = MediaQuery.of(context).size;
    TextTheme textTheme = Theme.of(context).textTheme;
    return Scaffold(
      resizeToAvoidBottomInset: false,
      body: SizedBox(
        width: double.maxFinite,
        child: Padding(
          padding: const EdgeInsets.all(20.0),
          child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                verticalGap(40.0),
                Text(
                  "Welcome",
                  style: textTheme.displayLarge,
                ),
                Text(
                  "Back!",
                  style: textTheme.displayLarge,
                ),
                verticalGap(20),
                const LoginForm(),
                verticalGap(40),
                SizedBox(
                  width: double.maxFinite,
                  child: Text(
                    "Sign in with",
                    textAlign: TextAlign.center,
                    style: textTheme.titleSmall,
                  ),
                ),
                verticalGap(10),
                const ThirdPartyAuthWidgets(),
                const Spacer(),
                Container(
                  alignment: Alignment.center,
                  child: RichText(
                      text: TextSpan(children: [
                    TextSpan(
                        text: "Not registered yet? ",
                        style: textTheme.titleSmall),
                    TextSpan(
                        text: "Register here",
                        style: GoogleFonts.robotoSlab(
                            fontSize: 12.5,
                            color: AppColors.accentColor,
                            fontWeight: FontWeight.bold))
                  ])),
                )
              ]),
        ),
      ),
    );
  }
}
