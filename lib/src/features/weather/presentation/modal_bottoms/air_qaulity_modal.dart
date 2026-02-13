import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:weatherapp/src/features/weather/domain/air_quality_model/air_quality_model.dart';
import 'package:weatherapp/src/features/weather/presentation/air_quality_Map.dart';

import '../../../../common/gaps/sized_box.dart';

Future<void> showAirQualityModal(
    AsyncSnapshot<AirQualityResponse?> snapAir, BuildContext context) async {
  bool isDarkMode = Theme.of(context).brightness == Brightness.dark;
  Size size = MediaQuery.of(context).size;
  List<String> listOfRecommendations = [
    snapAir.data!.healthRecommendations!.generalPopulation!,
    snapAir.data!.healthRecommendations!.elderly!,
    snapAir.data!.healthRecommendations!.lungDiseasePopulation!,
    snapAir.data!.healthRecommendations!.heartDiseasePopulation!,
    snapAir.data!.healthRecommendations!.athletes!,
    snapAir.data!.healthRecommendations!.pregnantWomen!,
    snapAir.data!.healthRecommendations!.children!,
  ];

  if (!context.mounted) return;
  showModalBottomSheet(
      context: context,
      backgroundColor: isDarkMode ? Colors.black87 : Colors.grey,
      isScrollControlled: true,
      showDragHandle: true,
      useSafeArea: true,
      builder: (_) {
        return SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.symmetric(vertical: 5, horizontal: 12),
            child: Column(
              children: [
                SizedBox(
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(
                        "Air Quality Index",
                        style: GoogleFonts.acme(
                            color: Colors.white,
                            fontSize: 18,
                            fontWeight: FontWeight.w600),
                      ),
                      horizontalGap(10),
                      Icon(CupertinoIcons.wind, color: Colors.white)
                    ],
                  ),
                ),
                verticalGap(10),
                AirQualityMap(),
                verticalGap(20),
                Row(
                  children: [
                    Column(
                      children: [
                        Text("Air Quality Status"),
                        verticalGap(1),
                        Text(
                          snapAir.data!.indexes.first.category!,
                          style:
                              GoogleFonts.roboto(fontWeight: FontWeight.w400),
                        )
                      ],
                    ),
                    Spacer(),
                    Column(
                      children: [
                        Text("Dominant Pollutant"),
                        verticalGap(1),
                        Text(
                          snapAir.data!.indexes.first.dominantPollutant!,
                          style:
                              GoogleFonts.roboto(fontWeight: FontWeight.w400),
                        )
                      ],
                    )
                  ],
                ),
                verticalGap(5),
                SizedBox(
                  child: Divider(
                    color: isDarkMode ? Colors.grey.shade800 : Colors.white24,
                    indent: size.width * 0.001,
                    endIndent: size.width * 0.001,
                  ),
                ),
                verticalGap(5),
                SizedBox(
                  width: double.maxFinite,
                  child: Text(
                    "Health Recommendations",
                    textAlign: TextAlign.start,
                  ),
                ),
                Column(
                    children: List.generate(
                        listOfHealthRecommendationKeys.length, (index) {
                  return Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      SizedBox(
                        width: double.maxFinite,
                        child: Text(listOfHealthRecommendationTitles[index]),
                      ),
                      Card(
                        child: ListTile(
                          leading: Icon(listOfHealthRecommendationIcons[index]),
                          title: Text(listOfRecommendations[index]),
                        ),
                      )
                    ],
                  );
                })),
              ],
            ),
          ),
        );
      });
}

List<String> listOfHealthRecommendationTitles = [
  "General Population",
  "Elderly",
  "Lung Disease Population",
  "Heart Disease Population",
  "Athletes",
  "Pregnant Women",
  "Children",
];

List<String> listOfHealthRecommendationKeys = [
  "generalPopulation",
  "elderly",
  "lungDiseasePopulation",
  "heartDiseasePopulation",
  "athletes",
  "pregnantWomen",
  "children",
];

List<IconData> listOfHealthRecommendationIcons = [
  Icons.groups,
  Icons.elderly,
  Icons.air,
  Icons.favorite,
  Icons.directions_run,
  Icons.pregnant_woman,
  Icons.child_care,
];
