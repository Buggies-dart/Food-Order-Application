import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_stripe/flutter_stripe.dart';
import 'package:food_delivery_app/firebase%20auth/firebase_options.dart';
import 'package:food_delivery_app/stripe%20payment/keys.dart';
import 'package:food_delivery_app/user%20onboarding/pageviews.dart';

void main() async{ 
  WidgetsFlutterBinding.ensureInitialized();
  Stripe.publishableKey = publishableKey;
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
);
  runApp(const 
  ProviderScope(child: MyApp()));
}
class MyApp extends StatelessWidget {
  
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return const MaterialApp( debugShowCheckedModeBanner: false,
      home: Onboarding()
    );
  }
}