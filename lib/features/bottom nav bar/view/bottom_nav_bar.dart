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
          dialog(
            context: context,
            title: "",
            content: SizedBox(
              height: size.height * 0.15,
              width: size.width * 0.5,
              child: Column(
                children: [
                  ListTile(
                    title: const Text(
                      "Become a Donor",
                      style: TextStyle(color: Colors.black),
                    ),
                    leading: const Icon(Icons.bloodtype),
                    onTap: () {
                      Navigator.pop(context);
                      navigateTo(context, const AddDonorForm());
                    },
                  ),
                  ListTile(
                    title: const Text(
                      "Request Blood",
                      style: TextStyle(color: Colors.black),
                    ),
                    leading: const Icon(Icons.bloodtype),
                    onTap: () {
                      Navigator.pop(context);
                      navigateTo(context, const RequestBlood());
                    },
                  ),
                ],
              ),
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
