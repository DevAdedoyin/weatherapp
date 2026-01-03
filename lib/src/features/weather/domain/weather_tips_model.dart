import 'package:cloud_firestore/cloud_firestore.dart';

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
  static Future<void> uploadRecommendations() async {
    final firestore = FirebaseFirestore.instance;

    for (final entry in _tips.entries) {
      await firestore
          .collection('recommendations')
          .doc(entry.key)
          .set(entry.value);
    }
  }

  static final Map<String, Map<String, List<String>>> _tips = {
    "200-232": {
      "clothing": [
        "Wearing waterproof boots and a rain jacket with a hood will help you stay dry.",
        "It is safer to avoid using metal umbrellas during strong lightning.",
        "Choosing quick drying fabrics can make being outdoors more comfortable.",
        "Darker clothing helps hide rain splashes and mud.",
        "Keeping spare socks nearby is helpful in case your feet get wet."
      ],
      "food": [
        "Warm soup or broth helps you stay comfortable indoors during storms.",
        "Herbal teas like ginger or chamomile can help you feel relaxed in damp weather.",
        "Comfort meals such as pasta or curry suit stormy conditions well.",
        "Warm porridge can help regulate your body temperature.",
        "Avoiding cold drinks can help you stay warm and comfortable."
      ],
      "activities": [
        "Staying indoors to read a book or watch a show is a good choice during storms.",
        "Indoor workouts or stretching are safer options when lightning is present.",
        "Creative indoor projects can help pass the time comfortably.",
        "Listening to calming music can reduce anxiety during heavy storms.",
        "Organizing photos or files is a productive way to spend time indoors."
      ],
      "safety": [
        "Staying away from windows helps reduce risk during heavy lightning.",
        "Unplugging sensitive electronics can help prevent power damage.",
        "Keeping a flashlight nearby is useful in case of power outages.",
        "Avoid using water appliances during intense lightning activity.",
        "Checking local alerts helps you stay informed about severe weather."
      ],
      "home_commute": [
        "Avoid unnecessary driving because roads can flood quickly.",
        "Charging your essential devices ahead of time is recommended.",
        "Securing outdoor items can help prevent wind related damage.",
        "Parking vehicles away from trees can reduce storm damage risk.",
        "Keeping emergency contacts easily accessible is a good precaution."
      ]
    },
    "300-321": {
      "clothing": [
        "Carrying a light umbrella or waterproof jacket helps keep you dry.",
        "Wearing shoes with good grip can help prevent slipping on wet surfaces.",
        "A hoodie is usually enough for short walks in light drizzle.",
        "Using a water resistant bag helps protect your belongings.",
        "Avoid fabric shoes that easily absorb water."
      ],
      "food": [
        "Warm drinks like lattes or cappuccinos feel comforting during drizzle.",
        "Light snacks pair well with mild rainy weather.",
        "Meals like stews or ramen create a cozy feeling indoors.",
        "Warm toast or pastries make quick and comforting meals.",
        "Avoid very cold drinks to stay comfortable in cool weather."
      ],
      "activities": [
        "Short walks with music or podcasts can be enjoyable in light rain.",
        "Visiting cafés or window shopping suits the drizzle mood.",
        "Drizzle creates great lighting for photography.",
        "Journaling feels relaxing during quiet rainy moments.",
        "Reading indoors is a calm way to enjoy the weather."
      ],
      "safety": [
        "Be cautious of slippery sidewalks and wet roads.",
        "Cyclists should wear reflective clothing for better visibility.",
        "Protect electronics from moisture exposure.",
        "Turning on headlights helps when visibility drops.",
        "Keeping your hands free helps maintain balance while walking."
      ],
      "home_commute": [
        "Driving a bit slower improves safety in wet conditions.",
        "Wiping your shoes before entering helps keep floors dry.",
        "Keeping windows mostly closed helps prevent indoor dampness.",
        "Dry umbrellas before storing them indoors.",
        "Using floor mats can help prevent slippery surfaces."
      ]
    },
    "500-531": {
      "clothing": [
        "Wearing a raincoat or trench coat provides better protection than an umbrella alone.",
        "Waterproof shoes help keep your feet dry throughout the day.",
        "Breathable layers help you stay warm without overheating.",
        "Using a hood gives better rain coverage than a cap.",
        "Carrying spare clothes can be helpful during long commutes."
      ],
      "food": [
        "Hot chocolate or spiced tea adds warmth on rainy days.",
        "Warm rice dishes and curries suit rainy weather well.",
        "Baked treats can make rainy evenings feel more enjoyable.",
        "Soups help keep you hydrated and warm.",
        "Avoid heavy greasy meals to stay comfortable."
      ],
      "activities": [
        "Indoor workouts or movie sessions are great ways to stay active and relaxed.",
        "Creative hobbies fit well with rainy weather.",
        "Listening to music while watching the rain can be calming.",
        "Decluttering indoor spaces feels productive on rainy days.",
        "Learning something new online works well indoors."
      ],
      "safety": [
        "Watch out for slippery roads and areas prone to flooding.",
        "Avoid standing under trees during heavy rainfall.",
        "Wearing reflective waterproof gear improves visibility.",
        "Allow extra braking distance when driving in the rain.",
        "Check drainage areas around your home for blockages."
      ],
      "home_commute": [
        "Plan ahead because commutes may take longer than usual.",
        "Keeping an umbrella near the door makes quick trips easier.",
        "Dry wet clothes quickly to prevent damp smells indoors.",
        "Using waterproof bags helps protect electronics.",
        "Avoid parking vehicles in areas prone to flooding."
      ]
    },
    "600-622": {
      "clothing": [
        "Wearing thermal layers along with winter accessories helps you stay warm.",
        "Waterproof boots with thick socks help protect your feet from the cold.",
        "Hand warmers are useful during extended time outdoors.",
        "Covering your ears and neck helps reduce heat loss.",
        "Insulated gloves provide better protection against freezing temperatures."
      ],
      "food": [
        "Hearty meals help your body stay warm in cold conditions.",
        "Hot cocoa is a comforting drink on snowy days.",
        "Fresh baked goods add warmth and comfort indoors.",
        "Warm breakfasts help boost energy in cold weather.",
        "Soups with protein help maintain strength during winter."
      ],
      "activities": [
        "Snow sports are enjoyable when conditions are safe.",
        "Indoor baking or puzzles are relaxing during snowy weather.",
        "Snowy landscapes offer beautiful photography opportunities.",
        "Light home workouts help keep your body warm.",
        "Watching winter themed movies adds to the cozy atmosphere."
      ],
      "safety": [
        "Walking carefully helps reduce the risk of slipping on icy surfaces.",
        "Watching for signs of frostbite is important during long outdoor exposure.",
        "Driving slowly is necessary because snow increases stopping distance.",
        "Footwear with good traction helps prevent falls.",
        "Keeping emergency supplies in your vehicle is a smart precaution."
      ],
      "home_commute": [
        "Clearing walkways helps reduce the risk of slips and falls.",
        "Keeping heating equipment well ventilated improves safety.",
        "Stocking essential supplies helps prepare for travel delays.",
        "Allowing extra time helps reduce stress during snowy commutes.",
        "Checking heating systems regularly helps avoid breakdowns."
      ]
    },
    "701-781": {
      "clothing": [
        "Wearing reflective clothing helps others see you in low visibility.",
        "Using a mask helps protect your breathing when dust or smoke is present.",
        "Light layers help your body adjust to changing temperatures.",
        "Avoid tight clothing that may restrict comfortable breathing.",
        "Wearing a hat can help reduce exposure to airborne particles."
      ],
      "food": [
        "Herbal teas can help soothe throat irritation.",
        "Vitamin rich fruits support your immune system.",
        "Light soups are easier on your breathing.",
        "Drinking warm water helps reduce dryness.",
        "Avoid spicy foods if the air feels irritating."
      ],
      "activities": [
        "Indoor workouts are safer during poor air quality.",
        "Yoga or meditation can help improve breathing comfort.",
        "Short walks are fine if visibility remains reasonable.",
        "Cleaning indoor spaces can help improve air freshness.",
        "Breathing exercises help support lung comfort."
      ],
      "safety": [
        "Using fog lights and maintaining distance improves driving safety.",
        "Avoid intense outdoor exercise during poor air quality.",
        "Checking air quality reports helps guide daily plans.",
        "Keeping windows closed helps limit dust exposure.",
        "Protective eyewear can help prevent eye irritation."
      ],
      "home_commute": [
        "Keeping windows closed helps protect indoor air quality.",
        "Using air purifiers can improve indoor comfort.",
        "Reducing travel helps limit exposure during poor visibility.",
        "Cleaning air filters regularly supports healthier air.",
        "Limiting outdoor exposure helps protect breathing."
      ]
    },
    "800": {
      "clothing": [
        "Wearing light breathable clothing helps you stay cool in sunny weather.",
        "Using sunglasses and a hat helps protect your eyes and face.",
        "Applying sunscreen helps protect your skin from sun damage.",
        "Loose fitting clothes improve airflow and comfort.",
        "Choosing lighter colors helps reflect heat."
      ],
      "food": [
        "Eating fresh fruits and salads helps you feel refreshed.",
        "Drinking hydrating beverages helps maintain energy levels.",
        "Outdoor meals feel enjoyable in clear weather.",
        "Light meals help prevent feeling sluggish.",
        "Electrolyte drinks help replace lost fluids."
      ],
      "activities": [
        "Outdoor sports and picnics are great choices in clear weather.",
        "Stargazing works well at night when skies are clear.",
        "Photography benefits from bright natural lighting.",
        "Morning walks help you avoid peak heat.",
        "Gardening is enjoyable under clear skies."
      ],
      "safety": [
        "Avoid staying in direct sunlight for extended periods.",
        "Using sunscreen with proper protection is important.",
        "Drinking water regularly helps prevent dehydration.",
        "Taking shade breaks helps avoid overheating.",
        "Wearing protective eyewear reduces eye strain."
      ],
      "home_commute": [
        "Walking or cycling is comfortable in clear weather.",
        "Opening windows helps ventilate indoor spaces.",
        "Outdoor plans are easier to enjoy on sunny days.",
        "Using sunshades helps reduce car heat buildup.",
        "Checking hydration before commuting is a good habit."
      ]
    },
    "801-804": {
      "clothing": [
        "Wearing layered clothing helps you adjust to temperature changes.",
        "Carrying a light jacket prepares you for cooler moments.",
        "Neutral colors suit the calm tone of cloudy weather.",
        "Comfortable shoes make longer walks easier.",
        "Keeping rain protection nearby is a smart precaution."
      ],
      "food": [
        "Warm comfort meals suit cloudy and cool days.",
        "Hot drinks add warmth and relaxation.",
        "Energy rich snacks help prevent tiredness.",
        "Balanced meals support steady focus.",
        "Warm breakfasts can help improve mood."
      ],
      "activities": [
        "Cloudy days are great for focused indoor work.",
        "Soft natural light is ideal for photography.",
        "Short outdoor walks help refresh your mind.",
        "Reading sessions feel calm and enjoyable.",
        "Planning tasks works well in quieter weather."
      ],
      "safety": [
        "Carrying rain protection helps if weather changes suddenly.",
        "Wearing brighter clothing improves visibility.",
        "Staying alert while biking improves safety.",
        "Checking forecasts helps you prepare for changes.",
        "Turning on lights earlier helps improve visibility indoors."
      ],
      "home_commute": [
        "Turning on indoor lights earlier improves comfort.",
        "Cloudy evenings are ideal for relaxing indoors.",
        "Monitoring weather updates helps with planning.",
        "Preparing rain gear before leaving home saves time.",
        "Keeping workspaces well lit helps reduce eye strain."
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
    }, orElse: () => "800");

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

class WeatherImages {
  static String weatherImages(double wId) {
    return wId >= 200 && wId <= 232
        ? "https://res.cloudinary.com/dhfuqqav8/image/upload/v1767269625/Weather%20Monitor/Home%20Description%20Images/thunderstormgif_fs49o9.gif"
        : wId >= 300 && wId <= 321
            ? "https://res.cloudinary.com/dhfuqqav8/image/upload/v1767269674/Weather%20Monitor/Home%20Description%20Images/drizzle_xjrqra.gif"
            : wId >= 500 && wId <= 531
                ? "https://res.cloudinary.com/dhfuqqav8/image/upload/v1767269699/Weather%20Monitor/Home%20Description%20Images/raining_xekkzh.gif"
                : wId >= 600 && wId <= 622
                    ? "https://res.cloudinary.com/dhfuqqav8/image/upload/v1767269739/Weather%20Monitor/Home%20Description%20Images/snow_mnvmwb.gif"
                    : wId >= 701 && wId <= 781
                        ? "https://res.cloudinary.com/dhfuqqav8/image/upload/v1767269799/Weather%20Monitor/Home%20Description%20Images/atmosphere_xnqnw6.gif"
                        : wId == 800
                            ? "https://res.cloudinary.com/dhfuqqav8/image/upload/v1767270944/Weather%20Monitor/Home%20Description%20Images/clear_sky_lrsppx.gif"
                            : wId >= 801 && wId <= 804
                                ? "https://res.cloudinary.com/dhfuqqav8/image/upload/v1767269795/Weather%20Monitor/Home%20Description%20Images/clouds_mbekqb.gif"
                                : "https://res.cloudinary.com/dhfuqqav8/image/upload/v1767269796/Weather%20Monitor/Home%20Description%20Images/wId_f28hd9.gif";
  }
}
