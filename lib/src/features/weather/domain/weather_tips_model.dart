class WeatherTipsCategory {
  final List<String> clothing;
  final List<String> food;
  final List<String> activities;
  final List<String> safety;
  final List<String> homeCommute;

  WeatherTipsCategory({
    required this.clothing,
    required this.food,
    required this.activities,
    required this.safety,
    required this.homeCommute,
  });
}

class WeatherTipsHelper {
  static final Map<String, Map<String, List<String>>> _tips = {
    "200-232": {
      // Thunderstorm
      "clothing": [
        "Wear waterproof boots and a rain jacket with a hood.",
        "Avoid carrying metal umbrellas if lightning is strong.",
        "Light, quick-dry fabrics work best if you must go outside."
      ],
      "food": [
        "Warm soup or broth keeps you comfortable indoors.",
        "Herbal teas (ginger, chamomile) help with the damp weather.",
        "Comfort food like pasta or curry is great during storms."
      ],
      "activities": [
        "Stay indoors and read a book or stream a show.",
        "Board games or indoor workouts are safer choices.",
        "Journal or do creative indoor projects."
      ],
      "safety": [
        "Stay away from windows during heavy lightning.",
        "Unplug sensitive electronics to prevent surge damage.",
        "Keep an emergency flashlight ready for power outages."
      ],
      "home_commute": [
        "Avoid unnecessary driving; roads may flood quickly.",
        "Charge devices in case the storm cuts power.",
        "Secure outdoor items (plants, bins, furniture) from strong winds."
      ]
    },
    "300-321": {
      // Drizzle
      "clothing": [
        "Carry a light umbrella or waterproof jacket.",
        "Wear shoes with good grip to avoid slipping.",
        "A hoodie works fine for short walks in drizzle."
      ],
      "food": [
        "Enjoy a warm latte or cappuccino.",
        "Light comfort snacks (sandwiches, pastries) go well with drizzle.",
        "Stews or ramen are cozy drizzle-weather meals."
      ],
      "activities": [
        "Great time for a short walk with music or podcasts.",
        "Indoor café hopping or window shopping.",
        "Photography – drizzle makes for moody shots."
      ],
      "safety": [
        "Watch out for slippery sidewalks and roads.",
        "Cyclists should use reflective gear.",
        "Avoid leaving electronics exposed to moisture."
      ],
      "home_commute": [
        "Drive slower; drizzle reduces tire grip.",
        "Wipe your shoes before entering to avoid wet floors.",
        "Keep windows slightly shut to prevent dampness indoors."
      ]
    },
    "500-531": {
      // Rain
      "clothing": [
        "Wear a raincoat or trench coat instead of just an umbrella.",
        "Waterproof boots or sneakers are essential.",
        "Layer with breathable fabrics to stay warm and dry."
      ],
      "food": [
        "Hot chocolate or spiced tea for comfort.",
        "Warm rice dishes, curries, or casseroles fit rainy moods.",
        "Baked goods like pie or cookies make rainy evenings better."
      ],
      "activities": [
        "Movie marathons or indoor workouts.",
        "Catch up on creative hobbies (painting, writing).",
        "Listen to calming music while watching the rain."
      ],
      "safety": [
        "Be cautious of slippery roads and possible flooding.",
        "Avoid standing under trees during strong rain.",
        "If cycling, wear reflective waterproof gear."
      ],
      "home_commute": [
        "Expect slower commutes; plan ahead.",
        "Keep an umbrella by the door for quick trips.",
        "Dry wet clothes promptly to avoid moldy smells indoors."
      ]
    },
    "600-622": {
      // Snow
      "clothing": [
        "Wear thermal layers, a winter coat, gloves, scarf, and hat.",
        "Waterproof snow boots with thick socks are essential.",
        "Hand warmers are useful for long outdoor exposure."
      ],
      "food": [
        "Hearty meals like stews, chili, or casseroles keep you warm.",
        "Hot cocoa with marshmallows is perfect for snowy days.",
        "Warm baked goods (cookies, pie) feel extra cozy."
      ],
      "activities": [
        "Perfect day for skiing, snowboarding, or sledding.",
        "Indoor activities like baking or puzzles are relaxing.",
        "Photography of snowy landscapes can be stunning."
      ],
      "safety": [
        "Walk carefully — sidewalks may be icy.",
        "Check for frostbite signs if outdoors too long.",
        "Drive slowly; snow increases stopping distance."
      ],
      "home_commute": [
        "Shovel paths and salt driveways to avoid slips.",
        "Keep heating equipment safe and ventilated.",
        "Stock pantry in case heavy snowfall delays travel."
      ]
    },
    "701-781": {
      // Atmosphere (fog, haze, dust)
      "clothing": [
        "Wear light, reflective clothing if walking outdoors.",
        "Use a mask if dust or smoke is heavy.",
        "Layers help if temps are cool in fog."
      ],
      "food": [
        "Hot herbal teas soothe throat irritation.",
        "Vitamin-rich fruits help counteract poor air quality.",
        "Light soups or porridge for comfort."
      ],
      "activities": [
        "Indoor workouts instead of outdoor jogging.",
        "Meditation or yoga at home.",
        "Short safe walks if visibility is not too poor."
      ],
      "safety": [
        "Drive with fog lights; keep extra distance.",
        "Avoid heavy exercise outdoors in smoky/hazy air.",
        "Check air quality index before going outside."
      ],
      "home_commute": [
        "Keep windows closed during dust or smoke.",
        "Use air purifiers if indoors.",
        "Avoid long commutes in poor visibility when possible."
      ]
    },
    "800": {
      // Clear sky
      "clothing": [
        "Light, breathable fabrics are ideal.",
        "Sunglasses and a hat protect against sun.",
        "Sunscreen is a must if outdoors."
      ],
      "food": [
        "Fresh salads, fruits, and smoothies suit sunny days.",
        "Hydrating drinks like lemonade or iced tea.",
        "BBQ or picnic-style meals outdoors."
      ],
      "activities": [
        "Perfect day for hiking, picnics, or outdoor sports.",
        "Stargazing at night with minimal clouds.",
        "Photography – clear skies mean vibrant colors."
      ],
      "safety": [
        "Avoid staying too long in direct sunlight.",
        "Use SPF 30+ sunscreen if outdoors.",
        "Stay hydrated throughout the day."
      ],
      "home_commute": [
        "Ideal weather for walking or cycling to work.",
        "Open windows for natural light and ventilation.",
        "Plan an outdoor meetup or family outing."
      ]
    },
    "801-804": {
      // Clouds
      "clothing": [
        "Layered clothing works best with fluctuating temps.",
        "Carry a light jacket just in case.",
        "Neutral colors suit cloudy moods."
      ],
      "food": [
        "Comfort food like soups or pasta works great.",
        "Warm drinks like cappuccinos or lattes feel cozy.",
        "Snack on nuts or energy bars for cloudy-day slumps."
      ],
      "activities": [
        "Great for productivity indoors.",
        "Photography lovers will enjoy diffused natural light.",
        "Take a short outdoor walk for fresh air."
      ],
      "safety": [
        "If it looks like rain, carry an umbrella.",
        "Stay visible with brighter clothes on gloomy days.",
        "Be cautious if biking; clouds may hide rain ahead."
      ],
      "home_commute": [
        "Turn on indoor lights earlier as daylight is dimmer.",
        "Enjoy a cozy evening movie or reading session.",
        "Keep an eye on forecasts; clouds may signal rain."
      ]
    }
  };

  static WeatherTipsCategory getAllTipsForWeather(double weatherId) {
    String key = _tips.keys.firstWhere((range) {
      if (range.contains('-')) {
        final parts = range.split('-');
        int start = int.parse(parts[0]);
        int end = int.parse(parts[1]);
        return weatherId >= start && weatherId <= end;
      } else {
        return weatherId == int.parse(range);
      }
    }, orElse: () => "800"); // default to clear

    final category = _tips[key]!;
    return WeatherTipsCategory(
      clothing: category["clothing"]!,
      food: category["food"]!,
      activities: category["activities"]!,
      safety: category["safety"]!,
      homeCommute: category["home_commute"]!,
    );
  }
}
