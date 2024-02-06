import "package:flutter/material.dart";

import "package:weatherapp/src/common/gaps/sized_box.dart";
import "package:weatherapp/src/features/authentication/presentation/login_form.dart";

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
                verticalGap(20.0),
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
              ]),
        ),
      ),
    );
  }
}
