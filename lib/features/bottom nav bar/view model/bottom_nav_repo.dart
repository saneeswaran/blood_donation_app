import 'package:blood_donation/features/home/view/home_page.dart';
import 'package:blood_donation/features/notifications/view/notifications_page.dart';
import 'package:blood_donation/features/profile/view/profile_page.dart';
import 'package:blood_donation/features/search/view/search_page.dart';
import 'package:flutter/material.dart';

class BottomNavRepo extends ChangeNotifier {
  int _currentIndex = 0;

  int get currentIndex => _currentIndex;

  final List<String> navLable = ["Home", "Search", "Notification", "Profile"];
  final List<IconData> navIcon = [
    Icons.home,
    Icons.search,
    Icons.notifications,
    Icons.person,
  ];
  final List<Widget> pages = [
    const HomePage(),
    const SearchPage(),
    const NotificationsPage(),
    const ProfilePage(),
  ];

  void setPage(int index) {
    _currentIndex = index;
    notifyListeners();
  }
}
