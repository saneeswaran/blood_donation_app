import 'package:blood_donation/core/color/appcolor.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

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

  bool _becomeADonor = false;

  bool get becomeADonor => _becomeADonor;

  void setBecomeADonor(bool value) {
    _becomeADonor = value;
    notifyListeners();
  }

  Widget buildProfileContent({required Size size}) {
    return ListView.builder(
      itemCount: profileContents.length + 1,
      shrinkWrap: true,
      physics: const ClampingScrollPhysics(),
      itemBuilder: (context, index) {
        if (index == 0) {
          return Consumer<ProfileUiController>(
            builder: (context, provider, child) {
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
                    const Icon(Icons.bloodtype, color: Appcolor.primaryColor),
                    const SizedBox(width: 20),
                    const Text("I want to Donate"),
                    const Spacer(),
                    Switch(
                      activeColor: Colors.white,
                      activeTrackColor: Appcolor.primaryColor,
                      value: provider._becomeADonor,
                      onChanged: (value) => provider.setBecomeADonor(value),
                    ),
                  ],
                ),
              );
            },
          );
        }
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
              Icon(profileIcons[index - 1], color: Appcolor.primaryColor),
              const SizedBox(width: 20),
              Text(profileContents[index - 1]),
              const Spacer(),
              const Icon(Icons.arrow_forward_ios, color: Appcolor.primaryColor),
            ],
          ),
        );
      },
    );
  }
}
