import 'package:animations/animations.dart';
import 'package:blood_donation/core/color/appcolor.dart';
import 'package:blood_donation/core/util/util.dart';
import 'package:blood_donation/features/bottom%20nav%20bar/view%20model/bottom_nav_repo.dart';
import 'package:blood_donation/features/form/view/add_donor_form.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:stylish_bottom_bar/stylish_bottom_bar.dart';

class BottomNavBar extends StatelessWidget {
  const BottomNavBar({super.key});

  @override
  Widget build(BuildContext context) {
    final Size size = MediaQuery.of(context).size;
    final provider = Provider.of<BottomNavRepo>(context);
    return Scaffold(
      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
      floatingActionButton: FloatingActionButton(
        shape: const CircleBorder(),
        backgroundColor: Colors.white,
        onPressed: () {
          bottomSheet(
            context: context,
            size: size,
            height: size.height * 0.2,
            child: Column(
              children: [
                OpenContainer(
                  transitionDuration: const Duration(milliseconds: 400),
                  transitionType: ContainerTransitionType.fadeThrough,
                  closedBuilder: (context, closedContainer) {
                    return TextButton(
                      onPressed: closedContainer,
                      child: const Text(
                        "Become a Donor",
                        style: TextStyle(color: Appcolor.primaryColor),
                      ),
                    );
                  },
                  openBuilder: (context, openContainer) => const AddDonorForm(),
                ),
              ],
            ),
          );
        },
        child: const Icon(Icons.add, color: Colors.black),
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
