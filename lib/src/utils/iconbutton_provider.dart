import 'package:flutter_riverpod/flutter_riverpod.dart';

// This class is used to manage the state of the IconButton in the password
// TextInputField
final iconButtonProvider = StateProvider<bool>((ref) {
  return false;
});

// This class is used to manage the state of the IconButton in the confirm password
// TextInputField
final iconButtonProviderCP = StateProvider<bool>((ref) {
  return false;
});
