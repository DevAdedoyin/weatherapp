class NewOnboardingData {
  final String title;
  final String images;
  final String description;

  NewOnboardingData(
      {required this.title, required this.images, required this.description});
}

List<NewOnboardingData> listOfOnboardingData = [
  NewOnboardingData(
      title: "Get Started",
      images: "assets/images/onboard1.png",
      description:
          "Create an account or sign in to unlock and enjoy all features of the app."),
  NewOnboardingData(
      title: "Enable Location",
      images: "assets/images/onboard2.png",
      description:
          "Allow access to your location so the app can deliver accurate weather updates."),
  NewOnboardingData(
      title: "Weather Updates",
      images: "assets/images/onboard3.png",
      description:
          "Stay informed with real-time conditions and reliable forecasts for every day."),
  NewOnboardingData(
      title: "Search Locations",
      images: "assets/images/onboard4.png",
      description:
          "Find detailed weather information for any city or place around the world."),
];


List<NewOnboardingData> listOfOnboardingDataLightMode = [
  NewOnboardingData(
      title: "Get Started",
      images: "assets/images/light_onb.png",
      description:
      "Create an account or sign in to unlock and enjoy all features of the app."),
  NewOnboardingData(
      title: "Enable Location",
      images: "assets/images/light_onb1.png",
      description:
      "Allow access to your location so the app can deliver accurate weather updates."),
  NewOnboardingData(
      title: "Weather Updates",
      images: "assets/images/light_onb2.png",
      description:
      "Stay informed with real-time conditions and reliable forecasts for every day."),
  NewOnboardingData(
      title: "Search Locations",
      images: "assets/images/light_onb3.png",
      description:
      "Find detailed weather information for any city or place around the world."),
];