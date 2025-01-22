import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_stripe/flutter_stripe.dart';
import 'package:food_delivery_app/Pages/navigation.dart';
import 'package:food_delivery_app/firebase%20auth/firebase_options.dart';
import 'package:food_delivery_app/state_management.dart';
import 'package:food_delivery_app/stripe%20payment/keys.dart';
import 'package:food_delivery_app/user%20onboarding/pageviews.dart';
import 'package:food_delivery_app/utils.dart';

void main() async{ 
  WidgetsFlutterBinding.ensureInitialized();
  Stripe.publishableKey = publishableKey;
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
);
// FirebaseAuthMethods(FirebaseAuth.instance).initializeApp;
  runApp(
  const ProviderScope(child: MyApp()));
}
class MyApp extends StatelessWidget {
  const MyApp({super.key});
  @override
Widget build(BuildContext context) {
return Consumer(
 builder: (context, ref, child) {
        // Trigger state loading from Firestore on app start
ref.read(Providers.myNotifProvider).loadStateFromFirestore();
return MaterialApp( debugShowCheckedModeBanner: false,
darkTheme: Palette.darkTheme, theme: Palette.lightTheme,
themeMode: ThemeMode.dark, home:  StreamBuilder<User?>(
stream: FirebaseAuth.instance.authStateChanges(),
builder: (context, snapshot) {
if (snapshot.connectionState == ConnectionState.waiting) {
 return const CircularProgressIndicator();
} else if (snapshot.hasData) {
 return const Navigation();
} else {
return const Onboarding();
}
        },
      ),
        );
      },
    );
  }
}