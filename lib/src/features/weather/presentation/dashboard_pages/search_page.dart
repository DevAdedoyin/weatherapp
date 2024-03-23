import "package:field_suggestion/box_controller.dart";
import "package:flutter/material.dart";
import "package:flutter_riverpod/flutter_riverpod.dart";

class SearchPage extends ConsumerStatefulWidget {
  const SearchPage({super.key});

  @override
  ConsumerState<ConsumerStatefulWidget> createState() => _SearchPageState();
}

class _SearchPageState extends ConsumerState<SearchPage> {

  // A box controller for default and local usable FieldSuggestion.
  final boxController = BoxController();

  // A box controller for network usable FieldSuggestion.
  final boxControllerNetwork = BoxController();

  // A text editing controller for default and local usable FieldSuggestion.
  final textController = TextEditingController();

  // A text editing controller for network usable FieldSuggestion.
  final textControllerNetwork = TextEditingController();

  

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Column(children: [
        SizedBox(
          child: Row(children: [
            TextField()
          ],),
        )
      ],),
    );
  }
}
