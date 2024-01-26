import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:weatherapp/src/features/authentication/data/datasources/facebook_signin_datasource.dart';

final facebookSignInProvider = FutureProvider((ref) async {
  return ref.watch(facebookSignInProvider_);
});
