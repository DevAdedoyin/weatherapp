import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter/material.dart';

class RouteErrorScreen extends ConsumerStatefulWidget {
  const RouteErrorScreen({errorMsg, super.key});

  @override
  ConsumerState<ConsumerStatefulWidget> createState() =>
      _RouteErrorScreenState();
}

class _RouteErrorScreenState extends ConsumerState<RouteErrorScreen> {
  @override
  Widget build(BuildContext context) {
    return Container();
  }
}
