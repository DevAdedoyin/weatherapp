import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:weatherapp/src/common/gaps/sized_box.dart';
import 'package:weatherapp/src/constants/app_colors.dart';
import 'package:weatherapp/src/features/geo_location/data/get_location.dart';

import '../../weather/data/repositories/bottom_nav_state.dart';

class UserLocation extends ConsumerStatefulWidget {
  const UserLocation({super.key});

  @override
  ConsumerState<ConsumerStatefulWidget> createState() => _UserLocationState();
}

class _UserLocationState extends ConsumerState<UserLocation> {
  @override
  void initState() {
    // TODO: implement initState
    GenerateWeatherLocation.getLocation();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {


    Size size = MediaQuery.of(context).size;
    TextTheme textTheme = Theme.of(context).textTheme;

    return Scaffold(
      body: SizedBox(
        width: double.maxFinite,
        child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            // mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              verticalGap(size.height * 0.10),
              SizedBox(
                width: size.width * 0.8,
                child: Text(
                  "Let Weather Monitor access your location to give you real-time weather datails on your location.",
                  textAlign: TextAlign.center,
                  style: textTheme.displaySmall,
                ),
              ),

                verticalGap(
                  size.height < 690 ? size.height * 0.04 : size.height * 0.10),
              SizedBox(
                width: size.width * 0.8,
                child: const Text(
                  "Please note that your location is NOT stored on our server. We only need your location to give you weather update for your current location.",
                  textAlign: TextAlign.center,
                  style: TextStyle(
                      fontSize: 12,
                      color: Colors.red,
                      fontWeight: FontWeight.bold),
                ),
              ),
              verticalGap(
                  size.height < 690 ? size.height * 0.04 : size.height * 0.10),
              Container(
                padding:
                    const EdgeInsets.symmetric(horizontal: 10, vertical: 10),
                height: 200,
                width: 200,
                decoration: BoxDecoration(
                    color: AppColors.accentColor,
                    borderRadius: BorderRadius.circular(100)),
                child: Container(
                  height: 170,
                  width: 170,
                  padding:
                      const EdgeInsets.symmetric(horizontal: 10, vertical: 10),
                  decoration: BoxDecoration(
                      color: AppColors.fontColor,
                      borderRadius: BorderRadius.circular(100)),
                  child: Image.asset(
                    "assets/images/location.png",
                    fit: BoxFit.contain,
                  ),
                ),
              ),
              if(size.height < 690 && size.height > 650)
                verticalGap(
                    size.height * 0.10)
              else verticalGap(size.height < 650 ? size.height * 0.04 : size.height * 0.10),
              const Text("Please wait while we fetch your location"),
              SizedBox(
                  width: size.width * 0.5,
                  child: const LinearProgressIndicator()),
              if(size.height < 690 && size.height > 650)
                verticalGap(
                   size.height * 0.10)
              else verticalGap(size.height < 650 ? size.height * 0.04 : size.height * 0.10),
              SizedBox(
                width: size.width * 0.7,
                child: ElevatedButton(
                  onPressed: () {
                    GenerateWeatherLocation.getLocation();
                  },
                  style: ButtonStyle(
                      elevation: const MaterialStatePropertyAll(5),
                      shape: const MaterialStatePropertyAll(
                          RoundedRectangleBorder(
                              borderRadius:
                                  BorderRadius.all(Radius.circular(10)))),
                      padding: const MaterialStatePropertyAll(
                          EdgeInsets.symmetric(vertical: 10)),
                      backgroundColor:
                          MaterialStatePropertyAll(AppColors.accentColor)),
                  child: Text(
                    "Enable Location",
                    style: textTheme.displaySmall,
                  ),
                ),
              )
            ]),
      ),
    );
  }
}
