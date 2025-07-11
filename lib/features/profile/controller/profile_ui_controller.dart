import 'package:blood_donation/core/color/appcolor.dart';
import 'package:blood_donation/features/form/view%20model/donor_repo.dart';
import 'package:blood_donation/features/profile/model/profile_tile_model.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class ProfileUiController extends ChangeNotifier {
  bool _becomeADonor = false;

  bool get becomeADonor => _becomeADonor;

  void setBecomeADonor(bool value) {
    _becomeADonor = value;
    notifyListeners();
  }

  Widget buildProfileContent({required Size size}) {
    return ListView.builder(
      itemCount: ProfileTileModel.profileTiles.length + 1,
      shrinkWrap: true,
      physics: const ClampingScrollPhysics(),
      itemBuilder: (context, index) {
        if (index == 0) {
          return Consumer2<ProfileUiController, DonorRepo>(
            builder: (context, provider, donorRepo, child) {
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
                      onChanged: (value) async {
                        provider.setBecomeADonor(value);
                        await donorRepo.changeDonorActiveStatus(
                          context: context,
                          id: donorRepo.currentDonor!.donorId.toString(),
                          status: _becomeADonor == true ? "active" : "inactive",
                        );
                      },
                    ),
                  ],
                ),
              );
            },
          );
        }
        return GestureDetector(
          onTap: () {
            ProfileTileModel.profileTiles[index - 1].onTap(context);
          },
          child: Container(
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
                Icon(
                  ProfileTileModel.profileTiles[index - 1].icon,
                  color: Appcolor.primaryColor,
                ),
                const SizedBox(width: 20),
                Text(ProfileTileModel.profileTiles[index - 1].title),
                const Spacer(),
                const Icon(
                  Icons.arrow_forward_ios,
                  color: Appcolor.primaryColor,
                ),
              ],
            ),
          ),
        );
      },
    );
  }
}
