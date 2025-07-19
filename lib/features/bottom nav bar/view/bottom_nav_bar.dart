import 'package:blood_donation/core/color/appcolor.dart';
import 'package:blood_donation/core/util/util.dart';
import 'package:blood_donation/features/bottom%20nav%20bar/view%20model/bottom_nav_repo.dart';
import 'package:blood_donation/features/form/view/add_donor_form.dart';
import 'package:blood_donation/features/search%20donor/view/request_blood.dart';
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
                ListTile(
                  leading: const Icon(
                    Icons.bloodtype,
                    color: Appcolor.mediaiuGrey,
                  ),
                  title: const Text(
                    "Become a donor",
                    style: TextStyle(
                      color: Colors.black,
                      fontSize: 16,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  onTap: () {
                    Navigator.pop(context);
                    navigateBottomToUp(
                      context: context,
                      route: const AddDonorForm(),
                    );
                  },
                ),
                ListTile(
                  leading: const Icon(
                    Icons.bloodtype,
                    color: Appcolor.mediaiuGrey,
                  ),
                  title: const Text(
                    "Request blood",
                    style: TextStyle(
                      color: Colors.black,
                      fontSize: 16,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  onTap: () {
                    Navigator.pop(context);
                    navigateBottomToUp(
                      context: context,
                      route: const RequestBlood(),
                    );
                  },
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
