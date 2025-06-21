import 'package:blood_donation/core/appcolor.dart';
import 'package:flutter/material.dart';

void main() {
  runApp(
    MaterialApp(
      title: "Blood Donation",
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        primaryColor: Appcolor.primaryColor,
        scaffoldBackgroundColor: Appcolor.scaffoldBackgroundColor,
      ),
    ),
  );
}
