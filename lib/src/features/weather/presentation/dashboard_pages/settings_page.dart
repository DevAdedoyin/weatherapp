import "dart:io";

import "package:firebase_auth/firebase_auth.dart";
import "package:flutter/cupertino.dart";
import "package:flutter/foundation.dart";
import "package:flutter/material.dart";
import "package:flutter_riverpod/flutter_riverpod.dart";
import "package:go_router/go_router.dart";
import "package:google_fonts/google_fonts.dart";
import "package:google_mobile_ads/google_mobile_ads.dart";
import "package:in_app_review/in_app_review.dart";
import "package:shared_preferences/shared_preferences.dart";
import "package:weatherapp/src/common/gaps/sized_box.dart";
import "package:weatherapp/src/constants/app_colors.dart";
import "package:weatherapp/src/features/app_update_notification/check_updates.dart";
import "package:weatherapp/src/features/authentication/data/datasources/auth_datasource.dart";
import "package:weatherapp/src/features/authentication/presentation/third_party_auth.dart";
import "package:weatherapp/src/features/share_app/share_app.dart";
import "package:weatherapp/src/features/weather/data/repositories/bottom_nav_state.dart";
import "package:weatherapp/src/routing/app_routes.dart";
import "package:weatherapp/src/routing/go_router_provider.dart";

import "../../../../themes/theme_notifier.dart";
import "../../../ads/ad_counter.dart";
import "../../../ads/data/repositories/banner_repository.dart";
import "../../../ads/data/repositories/interstital_repository.dart";
import "../../../notification/notification_service/notification_service.dart";
import "../../../ratings.dart";
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

    AdDisplayCounter.addDisplayCounter(
        ref.read(interstitialAdProvider.notifier),
        adPoint: 1.0);

    // TODO NOTE
    // In the future to load ad banners uncomment this code
    ref.read(settingsBannerAdProvider.notifier).loadAd();
  }

  @override
  void dispose() {
    // TODO: implement dispose

    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    TextTheme textTheme = Theme.of(context).textTheme;
    bool isDarkMode = Theme.of(context).brightness == Brightness.dark;
    bool isLightMode = ref.watch(switchModes);
    bool notificationState_ = ref.watch(notificationState);
    final bannerAd = ref.watch(settingsBannerAdProvider);
    final themeNotifier = ref.read(themeNotifierProvider.notifier);

    return SingleChildScrollView(
      child: SizedBox(
        // height: user == null ? size.height : null,
        child: Column(
          children: [
            verticalGap(size.height * 0.08),
            SizedBox(
              child: user?.photoURL == null
                  ? Container(
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(500),
                          color: AppColors.cardBgColor),
                      width: size.width * 0.3,
                      height: size.width * 0.3,
                      child: const Icon(Icons.person, size: 30),
                    )
                  : ClipRRect(
                      borderRadius: BorderRadius.circular(500),
                      child: Container(
                        decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(500),
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
            verticalGap(5),
            Text(
              user?.displayName ?? '',
              style: textTheme.headlineMedium,
            ),
            verticalGap(10),
            if (bannerAd != null)
              SizedBox(
                height: bannerAd.size.height.toDouble(),
                width: size.width * 0.90,
                child: AdWidget(ad: bannerAd),
              ),
            verticalGap(user == null ? 20 : 10),
            if (user == null) ThirdPartyAuthWidgets(),
            verticalGap(10),
            user == null
                ? Container(
                    margin: const EdgeInsets.symmetric(horizontal: 15),
                    child: Card(
                      color: isDarkMode
                          ? AppColors.cardDarkModeColor
                          : AppColors.cardLightModeColor,
                      child: ListTile(
                        leading: Icon(Icons.login,
                            color: isDarkMode ? Colors.red : Colors.blue),
                        title: Text(
                          "Login / Create account",
                          style: textTheme.bodyMedium,
                        ),
                        trailing: IconButton(
                          onPressed: () {
                            goRouter.go(AppRoutes.login);
                          },
                          icon: const Icon(Icons.arrow_forward_rounded),
                        ),
                      ),
                    ),
                  )
                : SizedBox(),
            verticalGap(10),
            Container(
              margin: const EdgeInsets.symmetric(horizontal: 15),
              child: Card(
                color: isDarkMode
                    ? AppColors.cardDarkModeColor
                    : AppColors.cardLightModeColor,
                child: ListTile(
                  leading: Icon(Icons.thermostat,
                      color: isDarkMode ? Colors.red : Colors.blue),
                  title: Text(
                    "Temperature unit",
                    style: textTheme.bodyMedium,
                  ),
                  trailing: IconButton(
                    onPressed: () {
                      AdDisplayCounter.addDisplayCounter(
                          ref.read(interstitialAdProvider.notifier));
                      goRouter.push(AppRoutes.temperatureScale);
                    },
                    icon: const Icon(Icons.arrow_forward_rounded),
                  ),
                ),
              ),
            ),
            user == null ? SizedBox() : verticalGap(10),
            user == null
                ? SizedBox()
                : Container(
                    margin: const EdgeInsets.symmetric(horizontal: 15),
                    child: Card(
                      // elevation: 3,
                      color: isDarkMode
                          ? AppColors.cardDarkModeColor
                          : AppColors.cardLightModeColor,
                      child: ListTile(
                        leading: Icon(Icons.lock,
                            color: isDarkMode ? Colors.red : Colors.blue),
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
                color: isDarkMode
                    ? AppColors.cardDarkModeColor
                    : AppColors.cardLightModeColor,
                child: ListTile(
                  leading: Icon(Icons.rate_review,
                      color: isDarkMode ? Colors.red : Colors.blue),
                  title: Text(
                    "Rate us",
                    style: textTheme.bodyMedium,
                  ),
                  trailing: IconButton(
                    onPressed: () {
                      if (kDebugMode) {
                        AppRatings.forceReview();
                      } else {
                        AppRatings.requestReview();
                      }
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
                color: isDarkMode
                    ? AppColors.cardDarkModeColor
                    : AppColors.cardLightModeColor,
                child: ListTile(
                  leading: Icon(Icons.support_agent,
                      color: isDarkMode ? Colors.red : Colors.blue),
                  title: Text(
                    "Contact us",
                    style: textTheme.bodyMedium,
                  ),
                  trailing: IconButton(
                    onPressed: () {
                      goRouter.push(AppRoutes.contact);
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
                color: isDarkMode
                    ? AppColors.cardDarkModeColor
                    : AppColors.cardLightModeColor,
                child: ListTile(
                  leading: Icon(Icons.share,
                      color: isDarkMode ? Colors.red : Colors.blue),
                  title: Text(
                    "Share app",
                    style: textTheme.bodyMedium,
                  ),
                  trailing: IconButton(
                    onPressed: () {
                      goRouter.push(AppRoutes.shareApp);
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
                // elevation: 3,
                color: isDarkMode
                    ? AppColors.cardDarkModeColor
                    : AppColors.cardLightModeColor,
                child: ListTile(
                    leading: Icon(Icons.notifications,
                        color: isDarkMode ? Colors.red : Colors.blue),
                    title: Text(
                      "Notification",
                      style: textTheme.bodyMedium,
                    ),
                    trailing: Switch(
                      value: notificationState_,
                      onChanged: (val) {
                        // themeNotifier.toggleTheme();
                        // ref.read(interstitialAdProvider.notifier).showAd();
                        AdDisplayCounter.addDisplayCounter(
                            ref.read(interstitialAdProvider.notifier));
                        if (val) {
                          setupFCM(ref);

                          ref.read(notificationState.notifier).state = val;

                          ScaffoldMessenger.of(context).showSnackBar(
                            SnackBar(
                              backgroundColor: Colors.green,
                              content: Text(
                                "Notifications have been turned on",
                                style: TextStyle(color: Colors.white),
                              ),
                              duration: Duration(seconds: 3),
                            ),
                          );
                        } else {
                          disableFCM();

                          ref.read(notificationState.notifier).state = val;

                          ScaffoldMessenger.of(context).showSnackBar(
                            SnackBar(
                              backgroundColor: Colors.red,
                              content: Text(
                                "Notifications have been turned off",
                                style: TextStyle(color: Colors.white),
                              ),
                              duration: Duration(seconds: 3),
                            ),
                          );
                        }
                      },
                    )),
              ),
            ),
            verticalGap(10),
            Container(
              margin: const EdgeInsets.symmetric(horizontal: 15),
              child: Card(
                // elevation: 3,
                color: isDarkMode
                    ? AppColors.cardDarkModeColor
                    : AppColors.cardLightModeColor,
                child: ListTile(
                    leading: Icon(Icons.mode_night,
                        color: isDarkMode ? Colors.red : Colors.blue),
                    title: Text(
                      "Switch theme",
                      style: textTheme.bodyMedium,
                    ),
                    trailing: Switch(
                      value: isDarkMode,
                      onChanged: (val) {
                        themeNotifier.toggleTheme();
                        AdDisplayCounter.addDisplayCounter(
                            ref.read(interstitialAdProvider.notifier));
                      },
                    )),
              ),
            ),
            verticalGap(10),
            Container(
              margin: const EdgeInsets.symmetric(horizontal: 15),
              child: Card(
                color: isDarkMode
                    ? AppColors.cardDarkModeColor
                    : AppColors.cardLightModeColor,
                child: ListTile(
                  leading: Icon(Icons.phone_iphone,
                      color: isDarkMode ? Colors.red : Colors.blue),
                  title: Text(
                    "Explore more apps",
                    style: textTheme.bodyMedium,
                  ),
                  trailing: IconButton(
                    onPressed: () {
                      goRouter.push(AppRoutes.moreApps);
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
                color: isDarkMode
                    ? AppColors.cardDarkModeColor
                    : AppColors.cardLightModeColor,
                child: ListTile(
                  leading: Icon(Icons.source,
                      color: isDarkMode ? Colors.red : Colors.blue),
                  title: Text(
                    "Data Sources",
                    style: textTheme.bodyMedium,
                  ),
                  trailing: IconButton(
                    onPressed: () {
                      goRouter.push(AppRoutes.dataSources);
                    },
                    icon: const Icon(Icons.arrow_forward_rounded),
                  ),
                ),
              ),
            ),
            verticalGap(10),
            user == null
                ? SizedBox()
                : Container(
                    margin: const EdgeInsets.symmetric(horizontal: 15),
                    child: Card(
                      // elevation: 3,
                      color: isDarkMode
                          ? AppColors.cardDarkModeColor
                          : AppColors.cardLightModeColor,
                      child: ListTile(
                        leading: Icon(Icons.logout,
                            color: isDarkMode ? Colors.red : Colors.blue),
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
                                          elevation:
                                              const MaterialStatePropertyAll(5),
                                          backgroundColor: MaterialStateProperty
                                              .all(Colors.black),
                                          padding:
                                              const MaterialStatePropertyAll(
                                            EdgeInsets.all(5),
                                          ),
                                          textStyle:
                                              const MaterialStatePropertyAll(
                                                  TextStyle(
                                                      fontWeight:
                                                          FontWeight.w700))),
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
                                          elevation:
                                              const MaterialStatePropertyAll(5),
                                          backgroundColor:
                                              MaterialStateProperty.all(
                                                  isDarkMode
                                                      ? Colors.red
                                                      : Colors.blue),
                                          padding:
                                              const MaterialStatePropertyAll(
                                            EdgeInsets.all(5),
                                          ),
                                          textStyle:
                                              const MaterialStatePropertyAll(
                                                  TextStyle(
                                                      fontWeight:
                                                          FontWeight.w700))),
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
            user == null
                ? SizedBox()
                : Container(
                    margin: const EdgeInsets.symmetric(horizontal: 15),
                    child: Card(
                      // elevation: 3,
                      color: isDarkMode
                          ? AppColors.cardDarkModeColor
                          : AppColors.cardLightModeColor,
                      child: ListTile(
                        leading: Icon(Icons.delete,
                            color: isDarkMode ? Colors.red : Colors.blue),
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
                                          elevation:
                                              const MaterialStatePropertyAll(5),
                                          backgroundColor: MaterialStateProperty
                                              .all(Colors.black),
                                          padding:
                                              const MaterialStatePropertyAll(
                                            EdgeInsets.all(5),
                                          ),
                                          textStyle:
                                              const MaterialStatePropertyAll(
                                                  TextStyle(
                                                      fontWeight:
                                                          FontWeight.w700))),
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
                                          elevation:
                                              const MaterialStatePropertyAll(5),
                                          backgroundColor:
                                              MaterialStateProperty.all(
                                                  isDarkMode
                                                      ? Colors.red
                                                      : Colors.blue),
                                          padding:
                                              const MaterialStatePropertyAll(
                                            EdgeInsets.all(5),
                                          ),
                                          textStyle:
                                              const MaterialStatePropertyAll(
                                                  TextStyle(
                                                      fontWeight:
                                                          FontWeight.w700))),
                                      child: const Text(
                                        'Delete',
                                        style: TextStyle(color: Colors.white),
                                      ),
                                      onPressed: () {
                                        FireAuth.deleteUserAccount(
                                            context: context);
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
            user == null ? verticalGap(5) : verticalGap(30),
            Text(
              "App Version: $appVersion",
              style: GoogleFonts.aBeeZee(color: Colors.white),
            ),
          ],
        ),
      ),
    );
  }
}
