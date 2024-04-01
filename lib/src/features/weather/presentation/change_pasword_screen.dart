import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:weatherapp/src/common/gaps/sized_box.dart';
import 'package:weatherapp/src/constants/app_colors.dart';
import 'package:weatherapp/src/themes/custom_themes.dart';
import 'package:weatherapp/src/utils/iconbutton_provider.dart';
import 'package:weatherapp/src/utils/is_loading_provider.dart';
import "package:weatherapp/src/utils/auth_validators.dart";

class ChangePasswordScreen extends ConsumerStatefulWidget {
  const ChangePasswordScreen({super.key});

  @override
  ConsumerState<ConsumerStatefulWidget> createState() =>
      _ChangePasswordScreenState();
}

class _ChangePasswordScreenState extends ConsumerState<ChangePasswordScreen> {
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
   final user = FirebaseAuth.instance.currentUser;

    return Scaffold(
      appBar: AppBar(
        title: const Text("Change password"),
        backgroundColor: AppColors.scaffoldBgColor,
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(15.0),
          child: Form(
            key: _formKey,
            child: Column(
              children: [
                SizedBox(
                  child: TextFormField(
                    style: GoogleFonts.roboto(
                        fontSize: 16, fontWeight: FontWeight.normal),
                    controller: _emailController,
                    keyboardType: TextInputType.emailAddress,
                    textInputAction: TextInputAction.next,
                    autofocus: false,
                    enabled: false,
                    validator: (email) => Validator.validateEmail(email: email),
                    decoration: darkThemeInputDecoration(
                        '${user?.email}', const Icon(Icons.email)),
                  ),
                ),
                verticalGap(20),
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
                      'New Password',
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
                verticalGap(20),
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
              ],
            ),
          ),
        ),
      ),
    );
  }
}
