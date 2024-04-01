// ignore_for_file: use_build_context_synchronously

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:weatherapp/src/common/widgets/auth_widgets/failed_alert.dart';
import 'package:weatherapp/src/common/widgets/auth_widgets/success_alert.dart';
import 'package:weatherapp/src/routing/app_routes.dart';

class FireAuth {
  static Future<User?> registerUsingEmailPassword(
      {required String name,
      required String email,
      required String password,
      BuildContext? context}) async {
    FirebaseAuth auth = FirebaseAuth.instance;
    User? user;
    try {
      UserCredential userCredential = await auth.createUserWithEmailAndPassword(
        email: email,
        password: password,
      );
      user = userCredential.user;
      await user!.updateDisplayName(name);
      await user.sendEmailVerification();
      await user.reload();
      user = auth.currentUser;

      final message =
          "Hi ${user!.displayName}, Your registration is almost complete. Please, kindly check your email for a verification link. Thank you";
      const messageHeader = "REGISTRATION SUCCESSFUL";
      successAuthAlertWidget(context!, message, messageHeader);
      Future.delayed(
          const Duration(seconds: 4), () => context.go(AppRoutes.login));
    } on FirebaseAuthException catch (e) {
      if (e.code == 'weak-password') {
        failedAuthAlertWidget(context!, e.message!, "REGISTRATION FAILED");
      } else if (e.code == 'email-already-in-use') {
        failedAuthAlertWidget(context!, e.message!, "REGISTRATION FAILED");
      }
    } catch (e) {
      print(e);
    }
    return user;
  }

  static Future<User?> signInUsingEmailPassword({
    required String email,
    required String password,
    required BuildContext context,
  }) async {
    FirebaseAuth auth = FirebaseAuth.instance;
    User? user;

    try {
      UserCredential userCredential = await auth.signInWithEmailAndPassword(
        email: email,
        password: password,
      );
      user = userCredential.user;

      final message =
          "Hi ${user!.displayName}, Your login is sucessful. Enjoy top notch weather forecast! Thank you.";
      const messageHeader = "LOGIN SUCCESSFUL";
      successAuthAlertWidget(context, message, messageHeader);
      Future.delayed(
          const Duration(seconds: 4), () => context.go(AppRoutes.dashboard));
    } on FirebaseAuthException catch (e) {
      if (e.code == 'user-not-found') {
        failedAuthAlertWidget(context, e.message!, "LOGIN FAILED");
      } else if (e.code == 'wrong-password') {
        failedAuthAlertWidget(context, e.message!, "LOGIN FAILED");
      }
    }

    return user;
  }

  static Future<dynamic> signOut({required BuildContext context}) async {
    FirebaseAuth auth = FirebaseAuth.instance;
    const message = "Hi, You have been successfully logged out. Thank you.";
    const messageHeader = "LOGOUT SUCCESSFUL";

    try {
      await auth.signOut();

      Future.delayed(
          const Duration(seconds: 4), () => context.go(AppRoutes.login));

      successAuthAlertWidget(context, message, messageHeader);
    } on FirebaseAuthException catch (e) {
      failedAuthAlertWidget(context, e.message!, "LOGOUT FAILED");
    }
  }

  static Future<void> deleteUserAccount({required BuildContext context}) async {
    const message =
        "Hi,\n\nyour account has been deleted successfully from our server.\n\nTo continue seeing more weather updates, you can create a new account\n\n.Thank You.";
    const messageHeader = "Account Removal Successful";
    try {
      await FirebaseAuth.instance.currentUser!.delete();

      successAuthAlertWidget(context, message, messageHeader);

      Future.delayed(
          const Duration(seconds: 4), () => context.go(AppRoutes.register));
    } on FirebaseAuthException catch (e) {
      failedAuthAlertWidget(context, e.message!, "ACCOUNT REMOVAL FAILED");
    } catch (e) {
      failedAuthAlertWidget(
          context,
          "Unable to delete your account. Please try again.",
          "ACCOUNT REMOVAL FAILED");

      // Handle general exception
    }
  }

  static Future<bool?> updatePasword(
      {required BuildContext context, required String newPassword}) async {
    final user = FirebaseAuth.instance.currentUser;
    final message =
        "Hi ${user?.displayName}, your password has been updated successfully. To continue seeing more weather updates, please kindly log in. Thank You.";
    const messageHeader = "Password Update Successful";
    try {
      await user?.updatePassword(newPassword);

      successAuthAlertWidget(context, message, messageHeader);

      Future.delayed(
          const Duration(seconds: 2), () => context.go(AppRoutes.login));
    } on FirebaseAuthException catch (e) {
      failedAuthAlertWidget(context, e.message!, "PASSWORD UPDATE FAILED");
    } catch (e) {
      failedAuthAlertWidget(
          context,
          "Unable to update your password. Please try again.",
          "PASSWORD UPDATE FAILED");
    }
    return false;
  }
}
