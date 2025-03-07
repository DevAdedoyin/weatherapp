import "package:firebase_auth/firebase_auth.dart";
import "package:flutter/material.dart";
import "package:flutter_riverpod/flutter_riverpod.dart";
import "package:go_router/go_router.dart";
import "package:shared_preferences/shared_preferences.dart";
import "package:weatherapp/src/common/gaps/sized_box.dart";
import "package:weatherapp/src/constants/app_colors.dart";
import "package:weatherapp/src/features/authentication/data/datasources/auth_datasource.dart";
import "package:weatherapp/src/routing/app_routes.dart";

import "../../../../themes/theme_notifier.dart";
import "../../data/repositories/switch.dart";

class SettingsPage extends ConsumerStatefulWidget {
  const SettingsPage({super.key});

  @override
  ConsumerState<ConsumerStatefulWidget> createState() => _SettingsPageState();
}

class _SettingsPageState extends ConsumerState<SettingsPage> {
  final user = FirebaseAuth.instance.currentUser;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    TextTheme textTheme = Theme.of(context).textTheme;
    bool isDarkMode = Theme.of(context).brightness == Brightness.dark;
    bool isLightMode = ref.watch(switchModes);
    final themeNotifier = ref.read(themeNotifierProvider.notifier);


    return SingleChildScrollView(
      child: Column(
        children: [
          verticalGap(size.height * 0.08),
          SizedBox(
            child: user?.photoURL == null
                ? Container(
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(100),
                        color: AppColors.cardBgColor),
                    width: size.width * 0.3,
                    height: size.width * 0.3,
                    child: const Icon(Icons.person, size: 30),
                  )
                : ClipRRect(
                    borderRadius: BorderRadius.circular(100),
                    child: Container(
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(100),
                          color: AppColors.cardBgColor),
                      width: size.width * 0.3,
                      height: size.width * 0.3,
                      padding: const EdgeInsets.all(5),
                      child: ClipOval(
                          child: Image.network(
                        "${user?.photoURL}",
                        fit: BoxFit.cover,
                      )),
                    ),
                  ),
          ),
          verticalGap(10),
          Text(
            "${user?.displayName}",
            style: textTheme.headlineMedium,
          ),
          verticalGap(20),
          Container(
            margin: const EdgeInsets.symmetric(horizontal: 15),
            child: Card(
              elevation: 3,
              color: isDarkMode ? AppColors.cardDarkModeColor : Colors.white,
              child: ListTile(
                leading: const Icon(Icons.lock, color: Colors.red),
                title: Text(
                  "Change password",
                  style: textTheme.bodyMedium,
                ),
                trailing: IconButton(
                  onPressed: () {
                    context.push(AppRoutes.changePassword);
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
              elevation: 3,
              color: isDarkMode ? AppColors.cardDarkModeColor : Colors.white,
              child: ListTile(
                leading: const Icon(Icons.logout, color: Colors.red),
                title: Text(
                  "Logout",
                  style: textTheme.bodyMedium,
                ),
                trailing: IconButton(
                  onPressed: () {
                    showDialog(
                      context: context,
                      builder: (BuildContext context) {
                        return AlertDialog(
                          // backgroundColor: AppColors.scaffoldBgColor,
                          title: Text(
                            'Logout',
                            style: textTheme.headlineMedium,
                          ),
                          content: Text(
                            "Are you sure you want to logout?",
                            style: textTheme.bodySmall,
                          ),
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
                                'Logout',
                                style: TextStyle(color: Colors.white),
                              ),
                              onPressed: () {
                                FireAuth.signOut(context: context);
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
          verticalGap(10),
          Container(
            margin: const EdgeInsets.symmetric(horizontal: 15),
            child: Card(
              elevation: 3,
              color: isDarkMode ? AppColors.cardDarkModeColor : Colors.white,
              child: ListTile(
                leading: const Icon(Icons.delete, color: Colors.red),
                title: Text(
                  "Remove account",
                  style: textTheme.bodyMedium,
                ),
                trailing: IconButton(
                  onPressed: () {
                    showDialog(
                      context: context,
                      builder: (BuildContext context) {
                        return AlertDialog(
                          // backgroundColor: AppColors.scaffoldBgColor,
                          title: Text(
                            'Delete your Account?',
                            style: textTheme.headlineMedium,
                          ),
                          content: Text(
                            '''
If you select Delete we will delete your account on our server.

Your app data will also be deleted and you won\'t be able to retrieve it.
''',
                            style: textTheme.bodySmall,
                          ),
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
          verticalGap(10),
          Container(
            margin: const EdgeInsets.symmetric(horizontal: 15),
            child: Card(
              elevation: 3,
              color: isDarkMode ? AppColors.cardDarkModeColor : Colors.white,
              child: ListTile(
                  leading: const Icon(Icons.mode_night, color: Colors.red),
                  title: Text(
                    "Switch theme",
                    style: textTheme.bodyMedium,
                  ),
                  trailing: Switch(
                    value: isDarkMode,
                    onChanged: (val)  {
                      themeNotifier.toggleTheme();
                    },
                  )),
            ),
          ),
        ],
      ),
    );
  }
}
