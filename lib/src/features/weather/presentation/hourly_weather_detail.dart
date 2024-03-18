import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class HourlyWeatherDetailsScreen extends ConsumerStatefulWidget {
  const HourlyWeatherDetailsScreen({super.key});

  @override
  ConsumerState<ConsumerStatefulWidget> createState() =>
      _HourlyWeatherDetailsScreenState();
}

class _HourlyWeatherDetailsScreenState
    extends ConsumerState<HourlyWeatherDetailsScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Column(
          children: [Text("Stuggart"), Text("18 March, Monday")],
        ),
      ),
    );
  }
}
