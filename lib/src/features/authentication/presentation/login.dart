import "package:flutter/material.dart";
import "package:flutter_riverpod/flutter_riverpod.dart";
import "package:google_fonts/google_fonts.dart";
import "package:weatherapp/src/common/gaps/sized_box.dart";
import 'package:email_validator/email_validator.dart';
import "package:weatherapp/src/constants/app_colors.dart";
import "package:weatherapp/src/themes/custom_themes.dart";

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
                LoginForm(),
              ]),
        ),
      ),
    );
  }
}

class LoginForm extends ConsumerStatefulWidget {
  const LoginForm({super.key});

  @override
  ConsumerState<ConsumerStatefulWidget> createState() => _LoginFormState();
}

class _LoginFormState extends ConsumerState<LoginForm> {
  final _formKey = GlobalKey<FormState>();

  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();
  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    TextTheme textTheme = Theme.of(context).textTheme;
    return Container(
      child: Form(
        key: _formKey,
        child: Column(
          children: [
            Container(
              child: TextFormField(
                style: GoogleFonts.roboto(
                    fontSize: 17, fontWeight: FontWeight.normal),
                controller: _emailController,
                keyboardType: TextInputType.emailAddress,
                textInputAction: TextInputAction.next,
                autofocus: false,
                validator: (email) {
                  if (EmailValidator.validate(email!)) {
                    return null;
                  } else {
                    return 'Please enter a valid email address';
                  }
                },
                decoration:
                    darkThemeInputDecoration('Email', const Icon(Icons.person)),
              ),
            ),
            verticalGap(25),
            Container(
              child: TextFormField(
                style: GoogleFonts.roboto(
                    fontSize: 17, fontWeight: FontWeight.normal),
                controller: _passwordController,
                textInputAction: TextInputAction.done,
                autofocus: false,
                validator: (email) {
                  if (EmailValidator.validate(email!)) {
                    return null;
                  } else {
                    return 'Please enter a valid email address';
                  }
                },
                decoration: darkThemeInputDecoration(
                    'Password', const Icon(Icons.lock)),
              ),
            ),
            verticalGap(5),
            Container(
              alignment: Alignment.centerRight,
              child: InkWell(
                onTap: () {},
                child: const Text(
                  "Forgot Password?",
                  style: TextStyle(
                      fontWeight: FontWeight.w900,
                      color: AppColors.accentColor),
                ),
              ),
            ),
            verticalGap(20),
            SizedBox(
              child: Row(
                children: [
                  Text(
                    "Sign In",
                    style: textTheme.displayMedium,
                  ),
                  Spacer(),
                  IconButton(
                      // color: AppColors.accentColor,
                      onPressed: () {},
                      icon: Icon(Icons.arrow_forward))
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}
