import 'package:blood_donation/core/color/appcolor.dart';
import 'package:blood_donation/core/constants/constants.dart';
import 'package:blood_donation/features/form/view%20model/donor_repo.dart';
import 'package:blood_donation/features/profile/controller/profile_ui_controller.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:skeletonizer/skeletonizer.dart';

class ProfilePage extends StatelessWidget {
  const ProfilePage({super.key});

  @override
  Widget build(BuildContext context) {
    final Size size = MediaQuery.of(context).size;
    return Scaffold(
      body: Container(
        padding: const EdgeInsets.all(20),
        height: size.height * 1,
        width: size.width * 1,
        child: SingleChildScrollView(
          child: Column(
            spacing: size.height * 0.02,
            children: [
              Consumer<DonorRepo>(
                builder: (context, provider, child) {
                  final isLoading = provider.isLoading;
                  final user = provider.currentDonor!;
                  return isLoading
                      ? Skeletonizer(
                          child: Column(
                            children: [
                              const SizedBox(height: 20),
                              const CircleAvatar(
                                radius: 60,
                                backgroundImage: CachedNetworkImageProvider(
                                  AppImages.noProfile,
                                ),
                              ),
                              Text(
                                user.name,
                                style: const TextStyle(
                                  color: Colors.black,
                                  fontSize: 20,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                              const Text(
                                "Last Donation Date : ",
                                style: TextStyle(
                                  color: Appcolor.mediaiuGrey,
                                  fontSize: 16,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                            ],
                          ),
                        )
                      : Column(
                          children: [
                            const SizedBox(height: 20),
                            const CircleAvatar(
                              radius: 60,
                              backgroundImage: CachedNetworkImageProvider(
                                AppImages.noProfile,
                              ),
                            ),
                            Text(
                              user.name,
                              style: const TextStyle(
                                color: Colors.black,
                                fontSize: 20,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                            const Text(
                              "Last Donation Date : ",
                              style: TextStyle(
                                color: Appcolor.mediaiuGrey,
                                fontSize: 16,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ],
                        );
                },
              ),
              context.read<ProfileUiController>().buildProfileContent(
                size: size,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
