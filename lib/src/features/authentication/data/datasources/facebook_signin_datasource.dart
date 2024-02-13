import 'package:flutter/widgets.dart';
import 'package:flutter_facebook_auth/flutter_facebook_auth.dart';
import 'package:flutter_login_facebook/flutter_login_facebook.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:weatherapp/src/common/widgets/auth_widgets/failed_alert.dart';
import 'package:weatherapp/src/common/widgets/auth_widgets/info_alert.dart';
import 'package:weatherapp/src/common/widgets/auth_widgets/success_alert.dart';

final facebookLogin = FacebookLogin();

Future<void> loginWithFacebook({BuildContext? context}) async {
  final result = await facebookLogin.logIn(customPermissions: ['email']);

  switch (result.status) {
    case FacebookLoginStatus.success:
      final accessToken = result.accessToken;
      final userInfo = await FacebookAuth.instance.getUserData();
      final userData = userInfo;
      final username = userData["name"];

      successAuthAlertWidget(
          context!,
          "Welcome $username, Your Facebook signin is successful. Enjoy top notch weather forecast! Thank you.",
          "Facebook Signin Successful");
      break;
    case FacebookLoginStatus.cancel:
      // User cancelled the login.
      infoAuthAlertWidget(context!, "Your signin process was cancelled.",
          "Authentication Cancelled");
      break;
    case FacebookLoginStatus.error:
      failedAuthAlertWidget(
          context!,
          "Your signin process failed. Please try again. Thank you.",
          "Authentication Failed");
      // There was an error during login.
      break;
  }
}

// final facebookSignInProvider_ = Provider((ref) => _loginWithFacebook());
