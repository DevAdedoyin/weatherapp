import "package:field_suggestion/box_controller.dart";
import "package:field_suggestion/field_suggestion.dart";
import "package:flutter/material.dart";
import "package:flutter_riverpod/flutter_riverpod.dart";
import "package:google_fonts/google_fonts.dart";
import "package:weatherapp/src/common/gaps/sized_box.dart";
import "package:weatherapp/src/constants/app_colors.dart";
import "package:weatherapp/src/features/weather/data/repositories/search_suggestion_data.dart";

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

  final List<SearchSuggestionModel> listOfCityData =
      SearchSuggestionModel.listOfCityData;

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    listOfCityData.sort((a, b) => a.cityNames.compareTo(b.cityNames));
    return SingleChildScrollView(
      child: SizedBox(
        // height: 30,
        child: Column(
          children: [
            verticalGap(10),
            SizedBox(
              width: size.width * 0.9,
              child: FieldSuggestion<SearchSuggestionModel>(
                itemBuilder: (_, position) {
                  return GestureDetector(
                    onTap: () {
                      setState(() {
                        textController.text =
                            listOfCityData[position].cityNames;
                      });

                      textController.selection = TextSelection.fromPosition(
                        TextPosition(offset: textController.text.length),
                      );
                    },
                    child: Card(
                      child: ListTile(
                        title: Text(listOfCityData[position].cityNames),
                        trailing: IconButton(
                          icon: const Icon(Icons.clear),
                          onPressed: () {
                            listOfCityData.removeAt(position);
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
                    hintStyle: GoogleFonts.roboto(
                      fontWeight: FontWeight.normal,
                      fontSize: 17,
                      color: Colors.grey[500],
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
                            const Icon(Icons.arrow_forward),
                          ],
                        )),
                    prefixIcon: const SizedBox(
                        child: Icon(
                      Icons.search,
                    ))),
                textController: textController,
                suggestions: SearchSuggestionModel.listOfCityData,
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
            ...listOfCityData.map((e) => Card(
                  margin:
                      const EdgeInsets.only(bottom: 10, left: 15, right: 15),
                  color: AppColors.scaffoldBgColor,
                  child: ListTile(
                    leading: const Icon(Icons.location_city_rounded),
                    title: Text(e.cityNames),
                  ),
                ))
          ],
        ),
      ),
    );
  }
}
