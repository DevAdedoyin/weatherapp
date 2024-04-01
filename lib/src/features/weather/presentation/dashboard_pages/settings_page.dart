import "package:flutter/material.dart";
import "package:flutter_riverpod/flutter_riverpod.dart";
import "package:weatherapp/src/common/gaps/sized_box.dart";
import "package:weatherapp/src/constants/app_colors.dart";
import "package:weatherapp/src/features/authentication/data/datasources/auth_datasource.dart";

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
          const SizedBox(
            child: Icon(Icons.person),
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
            margin: const EdgeInsets.symmetric(horizontal: 15),
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
                  onPressed: () {
                    FireAuth.signOut(context: context);
                  },
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
                  onPressed: () {
                    showDialog(
                      context: context,
                      builder: (BuildContext context) {
                        return AlertDialog(
                          backgroundColor: AppColors.scaffoldBgColor,
                          title: const Text('Delete your Account?'),
                          content: const Text(
                              'If you select Delete we will delete your account on our server.\n\nYour app data will also be deleted and you won\'t be able to retrieve it.'),
                          actions: [
                            TextButton(
                              style: ButtonStyle(
                                  elevation: const MaterialStatePropertyAll(5),
                                  backgroundColor:
                                      MaterialStateProperty.all(Colors.black),
                                  padding: const MaterialStatePropertyAll(
                                    EdgeInsets.all(5),
                                  ),
                                  textStyle: const MaterialStatePropertyAll(
                                      TextStyle(fontWeight: FontWeight.w700))),
                              child: const Text(
                                'Cancel',
                                style: TextStyle(color: Colors.white),
                              ),
                              onPressed: () {
                                Navigator.of(context).pop();
                              },
                            ),
                            TextButton(
                              style: ButtonStyle(
                                  elevation: const MaterialStatePropertyAll(5),
                                  backgroundColor: MaterialStateProperty.all(
                                      Colors.red[900]),
                                  padding: const MaterialStatePropertyAll(
                                    EdgeInsets.all(5),
                                  ),
                                  textStyle: const MaterialStatePropertyAll(
                                      TextStyle(fontWeight: FontWeight.w700))),
                              child: const Text(
                                'Delete',
                                style: TextStyle(color: Colors.white),
                              ),
                              onPressed: () {
                                FireAuth.deleteUserAccount(context: context);
                              },
                            ),
                          ],
                        );
                      },
                    );
                  },
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
