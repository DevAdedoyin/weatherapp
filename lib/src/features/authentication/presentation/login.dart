import "package:flutter/gestures.dart";
import "package:flutter/material.dart";
import "package:go_router/go_router.dart";
import "package:google_fonts/google_fonts.dart";
import "package:weatherapp/src/common/gaps/sized_box.dart";
import "package:weatherapp/src/common/widgets/auth_widgets/info_alert.dart";
import "package:weatherapp/src/constants/app_colors.dart";
import "package:weatherapp/src/features/authentication/presentation/login_form.dart";
import "package:weatherapp/src/features/authentication/presentation/third_party_auth.dart";
import "package:weatherapp/src/routing/app_routes.dart";

class LoginScreen extends StatelessWidget {
  const LoginScreen({super.key});

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
              height: size.height * 0.9,
              child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    verticalGap(50.0),
                    Text(
                      "Welcome",
                      style: textTheme.displayLarge,
                    ),
                    Text(
                      "Back!",
                      style: textTheme.displayLarge,
                    ),
                    verticalGap(30),
                    const LoginForm(),
                    verticalGap(50),
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
                            recognizer: TapGestureRecognizer()
                              ..onTap = () => context.go(AppRoutes.register),
                            style: GoogleFonts.robotoSlab(
                                fontSize: 12.5,
                                color: AppColors.accentColor,
                                fontWeight: FontWeight.bold))
                      ])),
                    ),
                    verticalGap(20),
                    SizedBox(
                      // height: 30,
                      width: double.maxFinite,
                      child: ElevatedButton(
                        onPressed: () {
                          infoAuthAlertWidget(
                              context,
                              "It's recommeded you sign in to enjoy the app's full feature. Thank you.",
                              "Recommendation",
                              onTap: () =>
                                  context.go(AppRoutes.userLocatorPage));
                        },
                        style: ButtonStyle(
                          backgroundColor:
                              MaterialStateProperty.all(AppColors.accentColor),
                          padding: MaterialStateProperty.all(EdgeInsets.zero),
                          shape: const MaterialStatePropertyAll(
                            RoundedRectangleBorder(
                              borderRadius: BorderRadius.all(
                                Radius.circular(10),
                              ),
                            ),
                          ),
                        ),
                        child: const Text(
                          "Skip Sign In",
                          style: TextStyle(
                              fontSize: 16, fontWeight: FontWeight.w700),
                        ),
                      ),
                    )
                  ]),
            ),
          ),
        ),
      ),
    );
  }
}
