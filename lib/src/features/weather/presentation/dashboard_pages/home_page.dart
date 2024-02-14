import "package:flutter/material.dart";
import "package:flutter_riverpod/flutter_riverpod.dart";

class HomePage extends ConsumerStatefulWidget {
  const HomePage({super.key});

  @override
  ConsumerState<ConsumerStatefulWidget> createState() => _HomePageState();
}

class _HomePageState extends ConsumerState<HomePage> {
  @override
  Widget build(BuildContext context) {
    return const CustomScrollView(
      slivers: <Widget>[
        SliverAppBar(
            // App bar configurations go here
            // Example: title, actions, floating, pinned, etc.
            ),
        // Other slivers go here
      ],
    );
  }
}
