import "package:flutter/material.dart";
import "package:weatherapp/src/common/gaps/sized_box.dart";
import "package:weatherapp/src/common/loading_indicator.dart";
import "package:weatherapp/src/constants/app_colors.dart";
import "package:weatherapp/src/features/authentication/data/datasources/auth_datasource.dart";
import "package:weatherapp/src/themes/custom_themes.dart";
import "package:flutter_riverpod/flutter_riverpod.dart";
import "package:google_fonts/google_fonts.dart";
import "package:weatherapp/src/utils/auth_validators.dart";
import "package:weatherapp/src/utils/iconbutton_provider.dart";
import "package:weatherapp/src/utils/is_loading_provider.dart";

class RegisterForm extends ConsumerStatefulWidget {
  const RegisterForm({super.key});

  @override
  ConsumerState<ConsumerStatefulWidget> createState() => _RegisterFormState();
}

class _RegisterFormState extends ConsumerState<RegisterForm> {
  final _formKey = GlobalKey<FormState>();
  final _usernameController = TextEditingController();
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();
  final _confirmPasswordController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    final isPasswordVisible = ref.watch(iconButtonProvider);
    final isConfirmPasswordVisible = ref.watch(iconButtonProviderCP);
    final isLoading = ref.watch(isAuthLoading);

    TextTheme textTheme = Theme.of(context).textTheme;
    return SizedBox(
      child: Form(
        key: _formKey,
        child: Column(
          children: [
            SizedBox(
              child: TextFormField(
                style: GoogleFonts.roboto(
                    fontSize: 16, fontWeight: FontWeight.normal),
                controller: _usernameController,
                keyboardType: TextInputType.text,
                textInputAction: TextInputAction.next,
                autofocus: false,
                validator: (username) => Validator.validateName(name: username),
                decoration: darkThemeInputDecoration(
                    'Username', const Icon(Icons.person)),
              ),
            ),
            verticalGap(size.height * 0.019),
            SizedBox(
              child: TextFormField(
                style: GoogleFonts.roboto(
                    fontSize: 16, fontWeight: FontWeight.normal),
                controller: _emailController,
                keyboardType: TextInputType.emailAddress,
                textInputAction: TextInputAction.next,
                autofocus: false,
                validator: (email) => Validator.validateEmail(email: email),
                decoration:
                    darkThemeInputDecoration('Email', const Icon(Icons.email)),
              ),
            ),
            verticalGap(size.height * 0.019),
            SizedBox(
              child: TextFormField(
                style: GoogleFonts.roboto(
                    fontSize: 16, fontWeight: FontWeight.normal),
                controller: _passwordController,
                textInputAction: TextInputAction.next,
                autofocus: false,
                obscureText: isPasswordVisible ? false : true,
                validator: (password) =>
                    Validator.validatePassword(password: password),
                decoration: darkThemeInputDecoration(
                  'Password',
                  const Icon(Icons.lock),
                  isPassword: true,
                  passwordIcon: IconButton(
                    onPressed: () {
                      ref.read(iconButtonProvider.notifier).state =
                          ref.read(iconButtonProvider.notifier).state
                              ? false
                              : true;
                    },
                    icon: Icon(isPasswordVisible
                        ? Icons.visibility_off
                        : Icons.visibility),
                  ),
                ),
              ),
            ),
            verticalGap(size.height * 0.019),
            SizedBox(
              child: TextFormField(
                style: GoogleFonts.roboto(
                    fontSize: 16, fontWeight: FontWeight.normal),
                controller: _confirmPasswordController,
                textInputAction: TextInputAction.done,
                obscureText: isConfirmPasswordVisible ? false : true,
                autofocus: false,
                validator: (confirmPassword) =>
                    Validator.validateConfirmPassword(
                        password: _passwordController.text,
                        confirmPassword: confirmPassword),
                decoration: darkThemeInputDecoration(
                  'Confirm Password',
                  const Icon(Icons.lock),
                  isCPassword: true,
                  passwordIcon: IconButton(
                    onPressed: () {
                      ref.read(iconButtonProviderCP.notifier).state =
                          ref.read(iconButtonProviderCP.notifier).state
                              ? false
                              : true;
                    },
                    icon: Icon(isConfirmPasswordVisible
                        ? Icons.visibility_off
                        : Icons.visibility),
                  ),
                ),
              ),
            ),
            // verticalGap(5),
            verticalGap(40),
            SizedBox(
              child: Row(
                children: [
                  Text(
                    "Register",
                    style: textTheme.displayMedium,
                  ),
                  const Spacer(),
                  isLoading
                      ? const SizedBox(
                          height: 17, width: 17, child: LoadingIndicator())
                      : Container(
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(25),
                            color: AppColors.accentColor,
                          ),
                          child: IconButton(
                              onPressed: () async {
                                if (_formKey.currentState!.validate()) {
                                  ref.read(isAuthLoading.notifier).state = true;
                                  await FireAuth.registerUsingEmailPassword(
                                    context: context,
                                    name: _usernameController.text,
                                    email: _emailController.text,
                                    password: _passwordController.text,
                                  );
                                  ref.read(isAuthLoading.notifier).state =
                                      false;
                                }
                              },
                              icon: const Icon(Icons.arrow_forward)),
                        )
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}
