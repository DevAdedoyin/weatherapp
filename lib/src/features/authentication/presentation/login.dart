import "package:flutter/gestures.dart";
import "package:flutter/material.dart";
import "package:go_router/go_router.dart";
import "package:google_fonts/google_fonts.dart";
import "package:flutter_riverpod/flutter_riverpod.dart";
import "package:weatherapp/src/common/gaps/sized_box.dart";
import "package:weatherapp/src/common/widgets/auth_widgets/info_alert.dart";
import "package:weatherapp/src/constants/app_colors.dart";
import "package:weatherapp/src/features/authentication/presentation/login_form.dart";
import "package:weatherapp/src/features/authentication/presentation/third_party_auth.dart";
import "package:weatherapp/src/routing/app_routes.dart";

import "../../weather/data/repositories/bottom_nav_state.dart";

class LoginScreen extends ConsumerWidget {
  const LoginScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    Size size = MediaQuery.of(context).size;
    TextTheme textTheme = Theme.of(context).textTheme;
    print("HEIGHT ${size.height}");

    final currentIndex = ref.watch(bottomNavState);

    bool isDarkMode = Theme
        .of(context)
        .brightness == Brightness.dark;
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
                    verticalGap(40.0),
                    Text(
                      "Welcome",
                      style: textTheme.headlineLarge,
                    ),
                    Text(
                      "Back!",
                      style: textTheme.headlineMedium,
                    ),
                    verticalGap(size.height < 650 ? 15 :30),
                    const LoginForm(),
                    verticalGap(size.height < 650 ? 15 : 30),
                    SizedBox(
                      width: double.maxFinite,
                      child: Text(
                        "Sign in with",
                        textAlign: TextAlign.center,
                        style: textTheme.titleMedium,
                      ),
                    ),
                    verticalGap(size.height < 650 ? 8 : 15),
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
                              ..onTap = () => context.push(AppRoutes.register),
                            style: GoogleFonts.robotoSlab(
                                fontSize: 15,
                                color: AppColors.accentColor,
                                fontWeight: FontWeight.bold))
                      ])),
                    ),
                    verticalGap(size.height < 650 ? 8 : 15),
                    SizedBox(
                      // height: 30,
                      width: double.maxFinite,
                      child: ElevatedButton(
                        onPressed: () {
                          ref.read(bottomNavState.notifier).state = 0;
                          infoAuthAlertWidget(
                              context,
                              """
It's recommeded you sign in to enjoy the app's full feature.

Please note that your location is not saved on our server.

Your location is only needed to make the app get weather details for that area.

Thank you.
                              """,
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
                        child: Text(
                          "Skip",
                          style: TextStyle(color: isDarkMode ? Colors.white : Colors.white),
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
