import "package:field_suggestion/box_controller.dart";
import "package:field_suggestion/field_suggestion.dart";
import "package:firebase_auth/firebase_auth.dart";
import "package:flutter/material.dart";
import "package:flutter_riverpod/flutter_riverpod.dart";
import "package:go_router/go_router.dart";
import "package:google_fonts/google_fonts.dart";
import "package:weatherapp/src/common/gaps/sized_box.dart";
import "package:weatherapp/src/common/widgets/auth_widgets/info_alert.dart";
import "package:weatherapp/src/constants/app_colors.dart";
import "package:weatherapp/src/features/weather/data/repositories/search_city_repo.dart";
import "package:weatherapp/src/features/weather/data/repositories/search_suggestion_data.dart";
import "package:weatherapp/src/routing/app_routes.dart";

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

  // A fake future builder that waits for 1 second to complete search.
  final strSuggestions = [
    'Lagos',
    'London',
    'New York City',
    'Beijing',
    'São Paulo',
    "Sydney"
  ];

  Future<List<String>> future(String input) => Future<List<String>>.delayed(
        const Duration(seconds: 1),
        () => strSuggestions
            .where((s) => s.toLowerCase().contains(input.toLowerCase()))
            .toList(),
      );

  List<SearchSuggestionModel> uniqueCityData = [];

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    uniqueCityData = SearchSuggestionModel.listOfCityData;
  }

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;

    // List<SearchSuggestionModel> uniqueCityData =
    //     listOfCityData.toSet().toList();

    final user = FirebaseAuth.instance.currentUser;

    uniqueCityData.sort((a, b) => a.cityNames.compareTo(b.cityNames));

    List<SearchSuggestionModel> topCityData = uniqueCityData;

    topCityData.sort((a, b) => a.cityNames.compareTo(b.cityNames));

    topCityData.shuffle();
    List<SearchSuggestionModel> random50Cities = topCityData.take(50).toList();
    List<SearchSuggestionModel> random15Cities = topCityData.take(15).toList();

    ref.watch(searchCity);

    TextTheme textTheme = Theme.of(context).textTheme;

    bool isDarkMode = Theme.of(context).brightness == Brightness.dark;

    return SingleChildScrollView(
      child: SizedBox(
        // height: 30,
        child: Column(
          children: [
            verticalGap(
                user == null ? size.height * 0.045 : size.height * 0.055),
            SizedBox(
              width: size.width * 0.9,
              child: FieldSuggestion<SearchSuggestionModel>(
                itemBuilder: (_, position) {
                  return GestureDetector(
                    onTap: () {
                      if (user == null) {
                        infoAuthAlertWidget(
                            context,
                            "Please kindly login or create and account to search for weather data of any location of your choice.",
                            "LOGIN REQUIRED", onTap: () {
                          context.go(AppRoutes.login);
                        });
                      } else {
                        setState(() {
                          textController.text =
                              uniqueCityData[position].cityNames;
                        });

                        textController.selection = TextSelection.fromPosition(
                          TextPosition(offset: textController.text.length),
                        );

                        ref.read(searchCity.notifier).state["city"] =
                            uniqueCityData[position].cityNames;

                        context.push(AppRoutes.searchCityWeatherDetails);
                      }
                    },
                    child: Card(
                      child: ListTile(
                        title: Text(uniqueCityData[position].cityNames),
                        trailing: IconButton(
                          icon: const Icon(Icons.clear),
                          onPressed: () {
                            uniqueCityData.removeAt(position);
                            boxController.refresh?.call();
                          },
                        ),
                      ),
                    ),
                  );
                },
                inputDecoration: InputDecoration(
                    hintText: 'Search location name...',
                    isCollapsed: true,
                    contentPadding: const EdgeInsets.symmetric(
                        horizontal: 10, vertical: 15),
                    border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(10),
                        borderSide: const BorderSide(
                            color: Colors.red, style: BorderStyle.solid)),
                    disabledBorder: const OutlineInputBorder(
                      borderSide: BorderSide(
                        color: Colors.red,
                      ),
                    ),
                    hintStyle: GoogleFonts.roboto(
                      fontWeight: FontWeight.normal,
                      fontSize: 17,
                      color: isDarkMode ? Colors.grey[500] : Colors.black54,
                      fontStyle: FontStyle.italic,
                    ),
                    suffixIcon: SizedBox(
                        width: 4,
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceAround,
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            Container(
                              width: 0.5,
                              height: 25,
                              color: Colors.grey,
                            ),
                            // horizontalGap(2),
                            InkWell(
                                onTap: () {
                                  if (user == null) {
                                    infoAuthAlertWidget(
                                        context,
                                        "Please kindly login or create an account to search for weather data of any location of your choice.",
                                        "LOGIN REQUIRED", onTap: () {
                                      context.go(AppRoutes.login);
                                    });
                                  } else {
                                    ref
                                        .read(searchCity.notifier)
                                        .state["city"] = textController.text;

                                    context.push(
                                        AppRoutes.searchCityWeatherDetails);
                                  }
                                },
                                splashColor: AppColors.thirdPartyIconBGColor,
                                borderRadius: BorderRadius.circular(50),
                                radius: 20,
                                child: const Icon(
                                  Icons.arrow_forward,
                                  color: Colors.red,
                                )),
                          ],
                        )),
                    prefixIcon: const SizedBox(
                        child: Icon(
                      Icons.search,
                      color: Colors.red,
                    ))),
                textController: textController,
                suggestions: uniqueCityData,
                boxController: boxController,
                separatorBuilder: (_, __) => const Divider(),
                search: (item, input) {
                  // Disable box, if item selected.
                  if (item.cityNames == input) return false;

                  return item.cityNames
                      .toString()
                      .toLowerCase()
                      .contains(input.toLowerCase());
                },
              ),
            ),
            verticalGap(10),
            Container(
              margin: const EdgeInsets.symmetric(horizontal: 15),
              width: double.maxFinite,
              child: Text(
                "Popular places",
                textAlign: TextAlign.start,
                style: textTheme.bodyMedium,
              ),
            ),
            verticalGap(10),
            if (user == null)
              ...random15Cities.map(
                (e) => Card(
                  elevation: 3,
                  margin:
                      const EdgeInsets.only(bottom: 10, left: 15, right: 15),
                  color: isDarkMode
                      ? AppColors.cardDarkModeColor
                      : AppColors.cardLightModeColor,
                  child: InkWell(
                    splashColor: AppColors.cardBgColor,
                    borderRadius: BorderRadius.circular(20),
                    onTap: () {
                      infoAuthAlertWidget(
                          context,
                          "Please kindly login or create an account to see more details",
                          "LOGIN REQUIRED", onTap: () {
                        context.go(AppRoutes.login);
                      });

                      // ref.read(searchCity.notifier).state["city"] = e.cityNames;
                      //
                      // context.push(AppRoutes.searchCityWeatherDetails);
                    },
                    child: ListTile(
                      leading: const Icon(
                        Icons.location_city_rounded,
                        color: Colors.red,
                      ),
                      title: Text(
                        e.cityNames,
                        style: textTheme.bodyMedium,
                      ),
                      trailing: Text(
                        e.continent,
                        style: textTheme.bodySmall,
                      ),
                    ),
                  ),
                ),
              )
            else
              ...random50Cities.map(
                (e) => Card(
                  // elevation:  3,
                  margin:
                      const EdgeInsets.only(bottom: 10, left: 15, right: 15),
                  color: isDarkMode
                      ? AppColors.cardDarkModeColor
                      : AppColors.cardLightModeColor,
                  child: InkWell(
                    splashColor: AppColors.cardBgColor,
                    borderRadius: BorderRadius.circular(20),
                    onTap: () {
                      ref.read(searchCity.notifier).state["city"] = e.cityNames;

                      context.push(AppRoutes.searchCityWeatherDetails);
                    },
                    child: ListTile(
                      leading: const Icon(
                        Icons.location_city_rounded,
                        color: Colors.red,
                      ),
                      title: Text(
                        e.cityNames,
                        style: textTheme.bodyMedium,
                      ),
                      trailing: Text(
                        e.continent,
                        style: textTheme.bodySmall,
                      ),
                    ),
                  ),
                ),
              )
          ],
        ),
      ),
    );
  }
}
