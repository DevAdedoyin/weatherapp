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

class ForgotPasswordScreen extends ConsumerStatefulWidget {
  const ForgotPasswordScreen({super.key});

  @override
  ConsumerState<ConsumerStatefulWidget> createState() =>
      _ForgotPasswordScreenState();
}

class _ForgotPasswordScreenState extends ConsumerState<ForgotPasswordScreen> {
  final _formKey = GlobalKey<FormState>();
  final _emailController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    final isPasswordVisible = ref.watch(iconButtonProvider);
    final isConfirmPasswordVisible = ref.watch(iconButtonProviderCP);
    final isLoading = ref.watch(isPasswordUpdating);

    TextTheme textTheme = Theme.of(context).textTheme;
    final user = FirebaseAuth.instance.currentUser;

    return Scaffold(
      appBar: AppBar(
        title: Text("Reset password", style: textTheme.titleMedium),
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
                    style: textTheme.titleMedium,
                    controller: _emailController,
                    keyboardType: TextInputType.emailAddress,
                    textInputAction: TextInputAction.next,
                    autofocus: false,
                    validator: (email) => Validator.validateEmail(email: email),
                    decoration: darkThemeInputDecoration(
                        'Email address', const Icon(Icons.email)),
                  ),
                ),
                verticalGap(20),
                SizedBox(
                  // height: 30,
                  width: double.maxFinite,
                  child: ElevatedButton(
                    onPressed: () async {
                      if (_formKey.currentState!.validate()) {
                        ref.read(isPasswordUpdating.notifier).state = true;

                        await FireAuth.forgotPassword(
                            context: context, email: _emailController.text);
                        ref.read(isAuthLoading.notifier).state = false;
                      }

                      ref.read(isPasswordUpdating.notifier).state = false;
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
                    child: isLoading
                        ? const SizedBox(
                            height: 15,
                            width: 15,
                            child: LoadingIndicator(),
                          )
                        : Text("Request password reset",
                            style: textTheme.titleSmall),
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
