import 'package:blood_donation/core/color/appcolor.dart';
import 'package:blood_donation/features/auth/view%20model/onboard_view_repo.dart';
import 'package:blood_donation/features/auth/view/onboard_page.dart';
import 'package:blood_donation/firebase_options.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);
  runApp(
    MultiProvider(
      providers: [ChangeNotifierProvider(create: (_) => OnboardViewRepo())],
      child: MaterialApp(
        title: "Blood Donation",
        debugShowCheckedModeBanner: false,
        theme: ThemeData(
          primaryColor: Appcolor.primaryColor,
          scaffoldBackgroundColor: Appcolor.scaffoldBackgroundColor,
        ),
        home: const OnboardPage(),
      ),
    ),
  );
}
