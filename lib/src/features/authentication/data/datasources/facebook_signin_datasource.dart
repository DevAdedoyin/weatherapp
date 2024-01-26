import 'package:flutter_login_facebook/flutter_login_facebook.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

final facebookLogin = FacebookLogin();

Future<void> _loginWithFacebook() async {
  final result = await facebookLogin.logIn(customPermissions: ['email']);
  switch (result.status) {
    case FacebookLoginStatus.success:
      // You're logged in with Facebook, use result.accessToken to make API calls.
      break;
    case FacebookLoginStatus.cancel:
      // User cancelled the login.
      break;
    case FacebookLoginStatus.error:
      // There was an error during login.
      break;
  }
}

final facebookSignInProvider_ = Provider((ref) => _loginWithFacebook());
