import 'package:weatherapp/src/features/onboarding/onboarding/onboarding_body.dart';

List<OnboardingBodyWidget> onboardingItemsList = [
  const OnboardingBodyWidget(
      image: "assets/images/onboard1.png",
      title: "Authentication",
      description:
          "Register or Sign-in to gain access to all features of the app."),
  const OnboardingBodyWidget(
      image: "assets/images/onboard2.png",
      title: "Location",
      description:
          "Access to your current location to give you weather data, based on the location."),
  const OnboardingBodyWidget(
      image: "assets/images/onboard3.png",
      title: "Weather Forecast",
      description:
          "Enjoy real-time weather updates and forecasts for future hours and dates."),
  const OnboardingBodyWidget(
      image: "assets/images/onboard4.png",
      title: "Location Search",
      description: "Search for weather data for any location round the world."),
];
