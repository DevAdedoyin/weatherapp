import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:weatherapp/src/features/authentication/data/datasources/google_signin_datasource.dart';

final googleSignInProvider = FutureProvider((ref) async {
  return ref.watch(googleSignInProvider_);
});
