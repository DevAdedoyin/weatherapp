import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:weatherapp/src/common/widgets/auth_widgets/failed_alert.dart';
import 'package:weatherapp/src/common/widgets/auth_widgets/success_alert.dart';
import 'package:weatherapp/src/routing/app_routes.dart';

Future<dynamic> signInWithGoogle({BuildContext? context}) async {
  try {
    FirebaseAuth auth = FirebaseAuth.instance;
    User? user;

    final GoogleSignInAccount? googleUser = await GoogleSignIn().signIn();

    final GoogleSignInAuthentication? googleAuth =
        await googleUser?.authentication;

    final credential = GoogleAuthProvider.credential(
      accessToken: googleAuth?.accessToken,
      idToken: googleAuth?.idToken,
    );

    final UserCredential userCredential =
        await auth.signInWithCredential(credential);

    user = userCredential.user;

    successAuthAlertWidget(
        context!,
        "Welcome ${user!.displayName}, Your Google signin is successful. Enjoy top notch weather forecast! Thank you.",
        "Google Signin Successful");

    context.go(AppRoutes.userLocatorPage);
    return await FirebaseAuth.instance.signInWithCredential(credential);
  } on Exception catch (e) {
    // TODO
    failedAuthAlertWidget(context!, e.toString(), "Authentication Failed");
  }
}

final googleSignInProvider_ = Provider((ref) => signInWithGoogle());
