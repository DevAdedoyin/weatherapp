import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class DailyWeatherDetail extends ConsumerWidget {
  const DailyWeatherDetail({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return const Scaffold(
      body: SingleChildScrollView(
        child: Column(
          children: <DailyWeatherDetail>[],
        ),
      ),
    );
  }
}
