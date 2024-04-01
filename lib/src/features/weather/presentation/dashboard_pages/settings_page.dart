import "package:flutter/material.dart";
import "package:flutter_riverpod/flutter_riverpod.dart";
import "package:font_awesome_flutter/font_awesome_flutter.dart";
import "package:weatherapp/src/common/gaps/sized_box.dart";
import "package:weatherapp/src/constants/app_colors.dart";

class SettingsPage extends ConsumerStatefulWidget {
  const SettingsPage({super.key});

  @override
  ConsumerState<ConsumerStatefulWidget> createState() => _SettingsPageState();
}

class _SettingsPageState extends ConsumerState<SettingsPage> {
  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Column(
        children: [
          verticalGap(20),
          Container(
            child: const SizedBox(
              child: Icon(Icons.person),
            ),
          ),
          const Text("Adedoyin Oluwaleke"),
          verticalGap(20),
          Container(
            margin: const EdgeInsets.symmetric(horizontal: 15),
            child: Card(
              elevation: 7,
              color: AppColors.scaffoldBgColor,
              child: ListTile(
                leading: const Icon(Icons.info),
                title: const Text("About app"),
                trailing: IconButton(
                  onPressed: () {},
                  icon: const Icon(Icons.arrow_forward_rounded),
                ),
              ),
            ),
          ),
          verticalGap(10),
          Container(
            margin: EdgeInsets.symmetric(horizontal: 15),
            child: Card(
              elevation: 7,
              color: AppColors.scaffoldBgColor,
              child: ListTile(
                leading: const Icon(Icons.lock),
                title: const Text("Change password"),
                trailing: IconButton(
                  onPressed: () {},
                  icon: const Icon(Icons.arrow_forward_rounded),
                ),
              ),
            ),
          ),
          verticalGap(10),
          Container(
            margin: const EdgeInsets.symmetric(horizontal: 15),
            child: Card(
              elevation: 7,
              color: AppColors.scaffoldBgColor,
              child: ListTile(
                leading: const Icon(Icons.logout),
                title: const Text("Logout"),
                trailing: IconButton(
                  onPressed: () {},
                  icon: const Icon(Icons.arrow_forward_rounded),
                ),
              ),
            ),
          ),
          verticalGap(10),
          Container(
            margin: const EdgeInsets.symmetric(horizontal: 15),
            child: Card(
              elevation: 7,
              color: AppColors.scaffoldBgColor,
              child: ListTile(
                leading: const Icon(Icons.delete),
                title: const Text("Remove account"),
                trailing: IconButton(
                  onPressed: () {},
                  icon: const Icon(Icons.arrow_forward_rounded),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
