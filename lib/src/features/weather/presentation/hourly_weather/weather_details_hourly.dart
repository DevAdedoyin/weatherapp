import 'package:flutter/material.dart';

class WeatherDetailsHourly extends StatelessWidget {
  const WeatherDetailsHourly({super.key});

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return SizedBox(
      child: Card(
        child: AnimatedContainer(
          duration: const Duration(seconds: 2),
          curve: Curves.easeIn,
          height: size.height * 0.15,
          child: ListView.builder(
              itemBuilder: (_, pos) {
                ListTile(
                  leading: Image.asset(""),
                  title: Text("Pressure"),
                  trailing: Text("20"),
                );
              },
              shrinkWrap: true,
              itemCount: 7),
        ),
      ),
    );
  }
}
