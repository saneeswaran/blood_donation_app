import 'package:blood_donation/core/color/appcolor.dart';
import 'package:flutter/material.dart';

class ProfileUiController extends ChangeNotifier {
  List<String> profileContents = [
    'Edit Profile',
    "Blood request",
    "Settings",
    "Invite Friends",
    "Privacy Policy",
    "Terms and Conditions",
    "About Us",
  ];
  List<IconData> profileIcons = [
    Icons.person,
    Icons.bloodtype,
    Icons.settings,
    Icons.share,
    Icons.privacy_tip,
    Icons.policy,
    Icons.info,
  ];

  Widget buildProfileContent({required Size size}) {
    return ListView.builder(
      itemCount: profileContents.length,
      shrinkWrap: true,
      physics: const ClampingScrollPhysics(),
      itemBuilder: (context, index) {
        return Container(
          margin: const EdgeInsets.symmetric(vertical: 10),
          padding: const EdgeInsets.symmetric(horizontal: 20),
          height: size.height * 0.07,
          width: size.width * 1,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(12),
            color: Appcolor.lightGrey,
          ),
          child: Row(
            children: [
              Icon(profileIcons[index], color: Appcolor.primaryColor),
              const SizedBox(width: 20),
              Text(profileContents[index]),
              const Spacer(),
              const Icon(Icons.arrow_forward_ios, color: Appcolor.primaryColor),
            ],
          ),
        );
      },
    );
  }
}
