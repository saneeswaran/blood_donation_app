// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:blood_donation/features/auth/view%20model/auth_repo.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class ProfileTileModel {
  final String title;
  final IconData icon;
  final Function(BuildContext context) onTap;
  ProfileTileModel({
    required this.title,
    required this.icon,
    required this.onTap,
  });
  static final List<ProfileTileModel> profileTiles = [
    ProfileTileModel(
      title: "Edit Profile",
      icon: Icons.person,
      onTap: (context) {},
    ),
    ProfileTileModel(
      title: "Blood request",
      icon: Icons.bloodtype,
      onTap: (context) {},
    ),
    ProfileTileModel(
      title: "Settings",
      icon: Icons.settings,
      onTap: (context) {},
    ),
    ProfileTileModel(
      title: "Invite Friends",
      icon: Icons.share,
      onTap: (context) {},
    ),
    ProfileTileModel(
      title: "Privacy Policy",
      icon: Icons.privacy_tip,
      onTap: (context) {},
    ),
    ProfileTileModel(
      title: "Terms and Conditions",
      icon: Icons.policy,
      onTap: (context) {},
    ),
    ProfileTileModel(title: "About Us", icon: Icons.info, onTap: (context) {}),
    ProfileTileModel(
      title: "Logout",
      icon: Icons.logout,
      onTap: (context) {
        context.read<AuthRepo>().logout();
      },
    ),
  ];
}
