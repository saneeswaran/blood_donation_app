import 'package:animations/animations.dart';
import 'package:blood_donation/core/color/appcolor.dart';
import 'package:blood_donation/features/bottom%20nav%20bar/view%20model/bottom_nav_repo.dart';
import 'package:blood_donation/features/form/view/add_donor_form.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:stylish_bottom_bar/stylish_bottom_bar.dart';

class BottomNavBar extends StatelessWidget {
  const BottomNavBar({super.key});

  @override
  Widget build(BuildContext context) {
    final provider = Provider.of<BottomNavRepo>(context);
    return Scaffold(
      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
      floatingActionButton: OpenContainer(
        transitionType: ContainerTransitionType.fadeThrough,
        transitionDuration: const Duration(milliseconds: 400),
        closedElevation: 6.0,
        closedShape: const RoundedRectangleBorder(
          borderRadius: BorderRadius.all(Radius.circular(50)),
        ),
        closedColor: Appcolor.scaffoldBackgroundColor,
        closedBuilder: (context, openContainer) {
          return FloatingActionButton(
            shape: const CircleBorder(),
            elevation: 0.0,
            tooltip: "Become a Donor",
            backgroundColor: Appcolor.scaffoldBackgroundColor,
            onPressed: openContainer,
            child: const Icon(Icons.add, color: Colors.black),
          );
        },
        openBuilder: (context, closedContainer) => const AddDonorForm(),
      ),
      bottomNavigationBar: StylishBottomBar(
        option: AnimatedBarOptions(iconStyle: IconStyle.animated),
        backgroundColor: Appcolor.lightGrey,
        currentIndex: provider.currentIndex,
        hasNotch: true,
        fabLocation: StylishBarFabLocation.center,
        notchStyle: NotchStyle.square,
        items: List.generate(
          provider.pages.length,
          (index) => BottomBarItem(
            title: Text(provider.navLable[index]),
            selectedColor: Appcolor.primaryColor,
            icon: Icon(provider.navIcon[index]),
          ),
        ),
        onTap: provider.setPage,
      ),
      body: provider.pages[provider.currentIndex],
    );
  }
}
