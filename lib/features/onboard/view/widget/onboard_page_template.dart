import 'package:blood_donation/core/color/appcolor.dart';
import 'package:blood_donation/core/util/util.dart';
import 'package:blood_donation/features/auth/view/sign_in_page.dart';
import 'package:blood_donation/features/auth/view/sign_up_page.dart';
import 'package:blood_donation/features/onboard/view%20model/onboard_view_repo.dart';
import 'package:blood_donation/features/widgets/custom_elevated_button.dart';
import 'package:dots_indicator/dots_indicator.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class OnboardPageTemplate extends StatelessWidget {
  const OnboardPageTemplate({super.key});

  @override
  Widget build(BuildContext context) {
    final onboardProvider = Provider.of<OnboardViewRepo>(context);
    final Size size = MediaQuery.of(context).size;
    return Scaffold(
      bottomNavigationBar: Container(
        padding: const EdgeInsets.symmetric(horizontal: 20),
        height: size.height * 0.1,
        width: size.width * 1,
        color: Appcolor.lightGrey,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            TextButton(
              onPressed: () => onboardProvider.skipOnboard(),
              child: const Text("Skip", style: TextStyle(color: Colors.black)),
            ),
            DotsIndicator(
              dotsCount: onboardProvider.onboardData.length,
              position: onboardProvider.currentIndex.toDouble(),
              animate: true,
              decorator: const DotsDecorator(
                activeColor: Appcolor.primaryColor,
                activeSize: Size(22, 10),
                activeShape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.all(Radius.circular(5)),
                ),
              ),
            ),
            IconButton(
              style: IconButton.styleFrom(
                backgroundColor: Appcolor.primaryColor,
              ),
              onPressed: () {
                onboardProvider.moveToNextPage();
              },
              icon: const Icon(
                Icons.arrow_forward,
                color: Colors.white,
                size: 35,
              ),
            ),
          ],
        ),
      ),
      body: PageView.builder(
        itemCount: onboardProvider.onboardData.length,
        controller: onboardProvider.pageController,
        onPageChanged: onboardProvider.setindex,
        itemBuilder: (context, index) {
          final onboard = onboardProvider.onboardData[index];
          return Column(
            children: [
              SizedBox(
                height: size.height * 0.5,
                width: size.width * 1,
                child: Image.asset(onboard.image, fit: BoxFit.contain),
              ),
              Expanded(
                child: Container(
                  padding: EdgeInsets.all(size.width * 0.03),
                  height: size.height * 0.5,
                  width: size.width * 1,
                  decoration: const BoxDecoration(
                    color: Appcolor.lightGrey,
                    borderRadius: BorderRadius.only(
                      topLeft: Radius.circular(150),
                      topRight: Radius.circular(150),
                    ),
                  ),
                  child: Column(
                    spacing: size.height * 0.01,
                    children: [
                      const SizedBox(height: 40),
                      Text(
                        onboard.title,
                        textAlign: TextAlign.center,
                        maxLines: 3,
                        overflow: TextOverflow.visible,
                        style: const TextStyle(
                          color: Colors.black,
                          fontSize: 28,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      onboardProvider.currentIndex == 3
                          ? const SizedBox.shrink()
                          : const SizedBox(height: 30),
                      Text(
                        onboard.description,
                        style: const TextStyle(
                          color: Appcolor.mediaiuGrey,
                          fontSize: 22,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      onboardProvider.currentIndex ==
                              onboardProvider.onboardData.length - 1
                          ? _customButtons(size: size, context: context)
                          : const Spacer(),
                    ],
                  ),
                ),
              ),
            ],
          );
        },
      ),
    );
  }

  Widget _customButtons({required Size size, required BuildContext context}) {
    return Column(
      children: [
        SizedBox(
          height: size.height * 0.06,
          width: size.width * 0.8,
          child: CustomElevatedButton(
            onPressed: () => navigateTo(context, const SignUpPage()),
            child: const Text("Sign Up", style: TextStyle(color: Colors.white)),
          ),
        ),
        const SizedBox(height: 20),
        SizedBox(
          height: size.height * 0.06,
          width: size.width * 0.8,
          child: CustomElevatedButton(
            onPressed: () => navigateTo(context, const SignInPage()),
            backgroundColor: Colors.white,
            child: const Text(
              "Sign In",
              style: TextStyle(color: Appcolor.primaryColor),
            ),
          ),
        ),
      ],
    );
  }
}
