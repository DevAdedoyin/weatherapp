import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:weatherapp/src/features/authentication/data/datasources/google_signout_datasource.dart';

final googleSignoutProvider =
    FutureProvider((ref) => ref.watch(googleSignOutProvider_));
