import "package:flutter/gestures.dart";
import "package:flutter/material.dart";
import "package:go_router/go_router.dart";
import "package:google_fonts/google_fonts.dart";
import "package:weatherapp/src/common/gaps/sized_box.dart";
import "package:weatherapp/src/constants/app_colors.dart";
import "package:weatherapp/src/features/authentication/presentation/register_form.dart";
import "package:weatherapp/src/features/authentication/presentation/third_party_auth.dart";
import "package:weatherapp/src/routing/app_routes.dart";

class RegisterScreen extends StatelessWidget {
  const RegisterScreen({super.key});

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    TextTheme textTheme = Theme.of(context).textTheme;
    return Scaffold(
      // resizeToAvoidBottomInset: false,
      body: SingleChildScrollView(
        physics: const BouncingScrollPhysics(),
        child: SizedBox(
          width: double.maxFinite,
          child: Padding(
            padding: const EdgeInsets.all(20.0),
            child: SizedBox(
              height: size.height * 0.95,
              child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    verticalGap(size.height * 0.07),
                    Text(
                      "Create an",
                      style: textTheme.displayLarge,
                    ),
                    Text(
                      "account",
                      style: textTheme.displayLarge,
                    ),
                    verticalGap(30),
                    const RegisterForm(),
                    verticalGap(size.height * 0.06),
                    SizedBox(
                      width: double.maxFinite,
                      child: Text(
                        "Sign up with",
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
                            text: "Registered already? ",
                            style: textTheme.titleSmall),
                        TextSpan(
                            text: "Sign In here",
                            recognizer: TapGestureRecognizer()
                              ..onTap = () => context.go(AppRoutes.register),
                            style: GoogleFonts.robotoSlab(
                                fontSize: 12.5,
                                color: AppColors.accentColor,
                                fontWeight: FontWeight.bold))
                      ])),
                    )
                  ]),
            ),
          ),
        ),
      ),
    );
  }
}
