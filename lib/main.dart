import 'package:blood_donation/core/color/appcolor.dart';
import 'package:blood_donation/features/auth/view%20model/auth_repo.dart';
import 'package:blood_donation/features/bottom%20nav%20bar/view%20model/bottom_nav_repo.dart';
import 'package:blood_donation/features/bottom%20nav%20bar/view/bottom_nav_bar.dart';
import 'package:blood_donation/features/onboard/view%20model/onboard_view_repo.dart';
import 'package:blood_donation/features/onboard/view/onboard_page.dart';
import 'package:blood_donation/firebase_options.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);
  runApp(
    MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (_) => OnboardViewRepo()),
        ChangeNotifierProvider(create: (_) => AuthRepo()),
        ChangeNotifierProvider(create: (_) => BottomNavRepo()),
      ],
      child: MaterialApp(
        title: "Blood Donation",
        debugShowCheckedModeBanner: false,
        theme: ThemeData(
          primaryColor: Appcolor.primaryColor,
          scaffoldBackgroundColor: Appcolor.scaffoldBackgroundColor,
        ),
        home: StreamBuilder(
          stream: FirebaseAuth.instance.authStateChanges(),
          builder: (context, asyncSnapshot) {
            if (asyncSnapshot.hasData) {
              return const BottomNavBar();
            } else {
              return const OnboardPage();
            }
          },
        ),
      ),
    ),
  );
}
