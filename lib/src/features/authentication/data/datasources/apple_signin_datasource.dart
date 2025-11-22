import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:sign_in_with_apple/sign_in_with_apple.dart';
import 'package:go_router/go_router.dart';
import 'package:weatherapp/src/routing/go_router_provider.dart';
import '../../../../common/widgets/auth_widgets/failed_alert.dart';
import '../../../../common/widgets/auth_widgets/success_alert.dart';
import '../../../../routing/app_routes.dart';
import 'google_signin_datasource.dart';

class AppleAuth {
  final FirebaseAuth _firebaseAuth = FirebaseAuth.instance;

  Stream<User?> authStateChanges() => _firebaseAuth.authStateChanges();

  String getUserEmail() => _firebaseAuth.currentUser?.email ?? "User";

  Future<UserCredential?> signInWithApple(
      {required BuildContext context}) async {
    try {
      // 1. Request fresh Apple credential
      final appleCredential = await SignInWithApple.getAppleIDCredential(
        scopes: [
          AppleIDAuthorizationScopes.email,
          AppleIDAuthorizationScopes.fullName,
        ],
      );

      final oAuthCredential = OAuthProvider("apple.com").credential(
        idToken: appleCredential.identityToken,
        accessToken: appleCredential.authorizationCode,
      );

      // 2. Attempt to sign in with Firebase
      final userCredential =
          await _firebaseAuth.signInWithCredential(oAuthCredential);
      final user = userCredential.user;

      successAuthAlertWidget(
        context,
        """
Welcome ${user!.displayName ?? ""},

Your Apple sign-in is successful.

Enjoy top notch weather forecast!
""",
        "Apple Sign-in Successful",
      );

      goRouter.pop();

      Future.delayed(const Duration(seconds: 2),
          () => GoRouter.of(context).go(AppRoutes.userLocatorPage));

      return userCredential;
    } on FirebaseAuthException catch (e) {
      if (e.code == 'credential-already-in-use') {
        final pendingCredential = e.credential;
        final email = e.email;

        if (email == null) {
          failedAuthAlertWidget(
              context,
              "Email not available for this Apple account.",
              "Authentication Failed");
          return null;
        }

        List<String> providers =
            await _firebaseAuth.fetchSignInMethodsForEmail(email);

        if (providers.contains('password')) {
          // Email/password account exists
          final password = await _promptForPassword(context);
          final existingUser = await _firebaseAuth.signInWithEmailAndPassword(
            email: email,
            password: password,
          );
          await existingUser.user?.linkWithCredential(pendingCredential!);

          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(
              content: Text(
                "Apple account linked to existing email/password account!",
                style: TextStyle(color: Colors.white),
              ),
              behavior: SnackBarBehavior.floating,
              margin: const EdgeInsets.all(10),
              backgroundColor: Colors.green,
              duration: const Duration(seconds: 3),
            ),
          );
          goRouter.push(AppRoutes.userLocatorPage);
          // return existingUser;
        } else if (providers.contains('google.com')) {
          // Google account exists
          final googleUser = await signInWithGoogle(context: context);
          await googleUser.user?.linkWithCredential(pendingCredential!);

          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(
              content: Text(
                "Apple account linked to existing Google account!",
                style: TextStyle(color: Colors.white),
              ),
              behavior: SnackBarBehavior.floating,
              margin: const EdgeInsets.all(10),
              backgroundColor: Colors.green,
              duration: const Duration(seconds: 3),
            ),
          );
          goRouter.push(AppRoutes.userLocatorPage);
          // return googleUser;
        } else if (providers.contains('apple.com')) {
          // Already signed in with Apple
          final newAppleCredential = await SignInWithApple.getAppleIDCredential(
            scopes: [
              AppleIDAuthorizationScopes.email,
              AppleIDAuthorizationScopes.fullName,
            ],
          );
          final newOAuthCredential = OAuthProvider("apple.com").credential(
            idToken: newAppleCredential.identityToken,
            accessToken: newAppleCredential.authorizationCode,
          );

          final newUserCredential =
              await _firebaseAuth.signInWithCredential(newOAuthCredential);

          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(
              content: Text(
                "Signed in successfully with your existing Apple account!",
                style: TextStyle(color: Colors.white),
              ),
              behavior: SnackBarBehavior.floating,
              margin: const EdgeInsets.all(10),
              backgroundColor: Colors.green,
              duration: const Duration(seconds: 3),
            ),
          );
          goRouter.push(AppRoutes.userLocatorPage);
          // return newUserCredential;
        } else {
          failedAuthAlertWidget(
            context,
            "Please sign in with your existing provider to link Apple.",
            "Authentication Failed",
          );
          return null;
        }
      } else {
        failedAuthAlertWidget(
            context,
            "Apple sign-in failed. Please, try again!",
            "Authentication Failed");
        return null;
      }
    } catch (e) {
      failedAuthAlertWidget(context, "Apple sign-in failed. Please, try again!",
          "Authentication Failed");
      return null;
    }
  }

  // Prompt user for password for email/password accounts
  Future<String> _promptForPassword(BuildContext context) async {
    String password = '';
    await showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: const Text('Enter your password'),
          content: TextField(
            obscureText: true,
            onChanged: (value) => password = value,
          ),
          actions: [
            TextButton(
              onPressed: () => Navigator.of(context).pop(),
              child: const Text('OK'),
            ),
          ],
        );
      },
    );
    return password;
  }
}
