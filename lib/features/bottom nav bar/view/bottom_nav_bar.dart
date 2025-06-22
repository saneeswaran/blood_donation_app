import 'package:blood_donation/core/color/appcolor.dart';
import 'package:blood_donation/features/bottom%20nav%20bar/view%20model/bottom_nav_repo.dart';
import 'package:curved_labeled_navigation_bar/curved_navigation_bar.dart';
import 'package:curved_labeled_navigation_bar/curved_navigation_bar_item.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class BottomNavBar extends StatelessWidget {
  const BottomNavBar({super.key});

  @override
  Widget build(BuildContext context) {
    final provider = Provider.of<BottomNavRepo>(context);
    return Scaffold(
      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
      floatingActionButton: FloatingActionButton(
        shape: const CircleBorder(),
        elevation: 0.0,
        tooltip: "Become a Donor",
        backgroundColor: Appcolor.primaryColor,
        onPressed: () {},
        child: const Icon(Icons.add, color: Colors.white),
      ),
      bottomNavigationBar: CurvedNavigationBar(
        buttonBackgroundColor: Appcolor.scaffoldBackgroundColor,
        backgroundColor: Appcolor.lightGrey,
        animationCurve: Curves.easeInOutCirc,
        animationDuration: const Duration(milliseconds: 300),
        items: List.generate(
          provider.pages.length,
          (index) => CurvedNavigationBarItem(
            child: Icon(provider.navIcon[index]),
            label: provider.navLable[index],
          ),
        ),
        onTap: provider.setPage,
      ),
      body: provider.pages[provider.currentIndex],
    );
  }
}
