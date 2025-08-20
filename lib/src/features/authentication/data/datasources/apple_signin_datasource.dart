import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:go_router/go_router.dart';
import 'package:sign_in_with_apple/sign_in_with_apple.dart';

import '../../../../common/widgets/auth_widgets/failed_alert.dart';
import '../../../../common/widgets/auth_widgets/success_alert.dart';
import '../../../../routing/app_routes.dart';

class AppleAuth {
  final FirebaseAuth _firebaseAuth = FirebaseAuth.instance;

  Stream<User?>? authStateChanges() => _firebaseAuth.authStateChanges();

  String getUserEmail() => _firebaseAuth.currentUser?.email ?? "User";

  Future<UserCredential?> signInWithApple({BuildContext? context}) async {
    try {
      User? user;

      final appleCredential = await SignInWithApple.getAppleIDCredential(
          scopes: [
            AppleIDAuthorizationScopes.email,
            AppleIDAuthorizationScopes.fullName
          ]);

      final oAuthCredential = OAuthProvider("apple.com").credential(
          idToken: appleCredential.identityToken,
          accessToken: appleCredential.authorizationCode);

      final UserCredential userCredential =
          await _firebaseAuth.signInWithCredential(oAuthCredential);

      user = userCredential.user;

      successAuthAlertWidget(
          context!,
          """
Welcome ${user!.displayName},

Your Apple sign-in is successful.

Enjoy top notch weather forecast!

Thank you.""",
          "Apple Sign-in Successful");

      context.go(AppRoutes.userLocatorPage);

      return await _firebaseAuth.signInWithCredential(oAuthCredential);
    } catch (e) {
      failedAuthAlertWidget(context!, e.toString(), "Authentication Failed");
      return null;
    }
    return null;
  }
}
