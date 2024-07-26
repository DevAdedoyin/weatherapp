import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:weatherapp/src/common/gaps/sized_box.dart';
import 'package:weatherapp/src/common/loading_indicator.dart';
import 'package:weatherapp/src/common/widgets/auth_widgets/info_alert.dart';
import 'package:weatherapp/src/constants/app_colors.dart';
import 'package:weatherapp/src/features/authentication/data/datasources/auth_datasource.dart';
import 'package:weatherapp/src/features/authentication/data/repositories/is_password_update.dart';
import 'package:weatherapp/src/routing/app_routes.dart';
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
    final isLoading = ref.watch(isPasswordUpdating);

    TextTheme textTheme = Theme.of(context).textTheme;
    final user = FirebaseAuth.instance.currentUser;
    bool isDarkMode = Theme.of(context).brightness == Brightness.dark;
    return Scaffold(
      appBar: AppBar(
        iconTheme: const IconThemeData(
          color: Colors.white ,
        ),
        title: const Text("Change password",
            style: TextStyle(
                color: Colors.white,
                fontWeight: FontWeight.w500,
                fontSize: 19)),
        backgroundColor:  Colors.red,
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
                    style: textTheme.titleMedium,
                    // controller: _emailController,
                    keyboardType: TextInputType.emailAddress,
                    readOnly: true,
                    textInputAction: TextInputAction.next,
                    autofocus: false,
                    enabled: false,
                    // validator: (email) => Validator.validateEmail(email: email),
                    decoration: themeInputDecoration(
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
                    decoration: themeInputDecoration(
                      'New Password',
                      const Icon(Icons.lock, ),
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
                    decoration: themeInputDecoration(
                      'Confirm Password',
                      const Icon(Icons.lock, ),
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
                verticalGap(40),
                SizedBox(
                  // height: 30,
                  width: double.maxFinite,
                  child: ElevatedButton(
                    onPressed: () async {
                      if (_formKey.currentState!.validate()) {
                        ref.read(isPasswordUpdating.notifier).state = true;

                        await FireAuth.updatePasword(
                            context: context,
                            newPassword: _passwordController.text);
                        ref.read(isAuthLoading.notifier).state = false;
                      }

                      ref.read(isPasswordUpdating.notifier).state = false;
                      // final loadingState =

                      // ref.read(isPasswordUpdating.notifier).state =
                      //     (await loadingState)!;
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
                          side: BorderSide.none
                        ),
                      ),
                    ),
                    child: isLoading
                        ? const SizedBox(
                            height: 15,
                            width: 15,
                            child: LoadingIndicator(),
                          )
                        : const Text("Update password", style: TextStyle(
                        color: Colors.white,
                        fontWeight: FontWeight.w500,
                        fontSize: 17)),
                  ),
                ),
                verticalGap(10),
                TextButton.icon(
                    onPressed: () {
                      context.go(AppRoutes.login);
                    },
                    icon: const Icon(
                      Icons.login_rounded,
                      color: Colors.white,
                    ),
                    style: const ButtonStyle(
                      backgroundColor: MaterialStatePropertyAll(Colors.black),
                    ),
                    label: const Text("Login", style:  TextStyle(
                        color: Colors.white,
                        fontWeight: FontWeight.w600,
                        fontSize: 19)))
              ],
            ),
          ),
        ),
      ),
    );
  }
}
