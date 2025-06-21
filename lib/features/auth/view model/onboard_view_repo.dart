import 'package:blood_donation/core/constants/constants.dart';
import 'package:blood_donation/features/auth/model/onboard_model.dart';
import 'package:flutter/material.dart';

class OnboardViewRepo extends ChangeNotifier {
  int currentIndex = 0;
  PageController pageController = PageController();

  List<OnboardModel> onboardData = const [
    OnboardModel(
      image: AppImages.onboard1,
      title: "Locate Donors\n Around You",
      description: "Some content",
    ),
    OnboardModel(
      image: AppImages.onboard2,
      title: "Discover Donors\n Based On Blood Type",
      description: "Some content",
    ),
    OnboardModel(
      image: AppImages.onboard3,
      title: "Real-Time Donor\n Available",
      description: "Some content",
    ),
    OnboardModel(
      image: AppImages.onboard3,
      title: "Welcome RedFlow",
      description: "Some content",
    ),
  ];

  void moveToNextPage() {
    if (currentIndex < onboardData.length - 1) {
      currentIndex++;
      pageController.animateToPage(
        currentIndex,
        duration: const Duration(milliseconds: 500),
        curve: Curves.easeInOut,
      );
      notifyListeners();
    }
  }

  void setindex(int index) {
    currentIndex = index;
    notifyListeners();
  }

  void skipOnboard() {
    currentIndex = onboardData.length - 1;
    pageController.jumpToPage(currentIndex);
    notifyListeners();
  }
}
