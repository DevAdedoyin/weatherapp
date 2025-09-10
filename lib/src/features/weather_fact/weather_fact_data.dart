import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:weatherapp/src/features/weather_fact/weather_fact_list.dart';

Future<void> addWeatherFacts() async {
  DatabaseReference ref = FirebaseDatabase.instance.ref("weatherFacts");

  final String imageUrl =
      "https://images.unsplash.com/photo-1707396173411-ce001d65c3cb?q=80&w=1480&auto=format&fit=crop&ixlib=rb-4.1.0&ixid=M3wxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8fA%3D%3D";



  for (int i = 0; i < facts.length; i++) {
    facts[i].addAll({"imageUrl": imageUrl});
  }

  ref.set({
    "facts": facts,
  });

  print(
      "✅ ${facts.length} facts with detailed descriptions added successfully");
}
