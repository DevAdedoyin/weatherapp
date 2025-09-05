import 'package:flutter/material.dart';
import 'package:weatherapp/src/features/onboarding/new_onboarding/new_onboarding_page.dart';

import 'new_onboarding_data.dart';

List<Widget> listOfOnboardingPages = [
  NewOnboardingPage(
      title: listOfOnboardingData[0].title,
      image: listOfOnboardingData[0].images,
      description: listOfOnboardingData[0].description),
  NewOnboardingPage(
      title: listOfOnboardingData[1].title,
      image: listOfOnboardingData[1].images,
      description: listOfOnboardingData[1].description),
  NewOnboardingPage(
      title: listOfOnboardingData[2].title,
      image: listOfOnboardingData[2].images,
      description: listOfOnboardingData[2].description),
  NewOnboardingPage(
      title: listOfOnboardingData[3].title,
      image: listOfOnboardingData[3].images,
      description: listOfOnboardingData[3].description),
];

List<Widget> listOfOnboardingPagesLightMode = [
  NewOnboardingPage(
      title: listOfOnboardingDataLightMode[0].title,
      image: listOfOnboardingDataLightMode[0].images,
      description: listOfOnboardingDataLightMode[0].description),
  NewOnboardingPage(
      title: listOfOnboardingDataLightMode[1].title,
      image: listOfOnboardingDataLightMode[1].images,
      description: listOfOnboardingDataLightMode[1].description),
  NewOnboardingPage(
      title: listOfOnboardingDataLightMode[2].title,
      image: listOfOnboardingDataLightMode[2].images,
      description: listOfOnboardingDataLightMode[2].description),
  NewOnboardingPage(
      title: listOfOnboardingDataLightMode[3].title,
      image: listOfOnboardingDataLightMode[3].images,
      description: listOfOnboardingDataLightMode[3].description),
];
