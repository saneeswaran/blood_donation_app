import 'package:blood_donation/core/color/appcolor.dart';
import 'package:blood_donation/core/constants/constants.dart';
import 'package:blood_donation/core/util/util.dart';
import 'package:blood_donation/features/auth/view%20model/auth_repo.dart';
import 'package:blood_donation/features/bottom%20nav%20bar/view/bottom_nav_bar.dart';
import 'package:blood_donation/features/widgets/custom_elevated_button.dart';
import 'package:blood_donation/features/widgets/custom_text_formfield.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:provider/provider.dart';

class SignInPage extends StatelessWidget {
  const SignInPage({super.key});

  @override
  Widget build(BuildContext context) {
    final emailController = TextEditingController();
    final passwordController = TextEditingController();
    final formKey = GlobalKey<FormState>();
    final Size size = MediaQuery.of(context).size;
    return Scaffold(
      appBar: AppBar(backgroundColor: Appcolor.scaffoldBackgroundColor),
      body: Padding(
        padding: const EdgeInsets.all(20),
        child: SingleChildScrollView(
          child: Form(
            key: formKey,
            child: Column(
              spacing: size.height * 0.02,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                SizedBox(height: size.height * 0.1),
                const Text(
                  "Sign In Your Account",
                  style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold),
                ),
                CustomTextFormfield(
                  hintText: "Email",
                  controller: emailController,
                ),
                Consumer<AuthRepo>(
                  builder: (context, provider, child) {
                    final isShow = provider.isShowPassword;
                    return CustomTextFormfield(
                      hintText: "Password",
                      controller: passwordController,
                      obScureText: !isShow,
                      suffixIcon: IconButton(
                        onPressed: () {
                          provider.showPassword();
                        },
                        icon: Icon(
                          isShow ? Icons.visibility : Icons.remove_red_eye,
                        ),
                      ),
                    );
                  },
                ),
                SizedBox(
                  height: size.height * 0.07,
                  width: size.width * 1,
                  child: Consumer<AuthRepo>(
                    builder: (context, provider, child) {
                      final isLoading = provider.isLoading;
                      return CustomElevatedButton(
                        onPressed: () async {
                          if (formKey.currentState!.validate()) {
                            bool isSuccess = await provider.login(
                              context: context,
                              email: emailController.text,
                              password: passwordController.text,
                            );
                            if (isSuccess && context.mounted) {
                              navigateAndFinish(context, const BottomNavBar());
                            }
                          }
                        },
                        child: isLoading
                            ? const CircularProgressIndicator.adaptive()
                            : const Text(
                                "Sign Up",
                                style: TextStyle(color: Colors.white),
                              ),
                      );
                    },
                  ),
                ),
                _dividerRow(),
                Center(child: _signInWithGoogle(size: size)),
                _moveToLoginPage(context: context),
              ],
            ),
          ),
        ),
      ),
    );
  }

  // Widget _bloodDropDownButton() {
  //   return Consumer<AuthRepo>(
  //     builder: (context, provider, child) {
  //       final types = provider.bloodTypes;
  //       final items = types
  //           .map((e) => DropdownMenuItem(value: e, child: Text(e)))
  //           .toList();
  //       return DropdownButtonFormField(
  //         decoration: InputDecoration(
  //           filled: true,
  //           fillColor: Appcolor.lightGrey,
  //           enabledBorder: OutlineInputBorder(
  //             borderRadius: BorderRadius.circular(10),
  //             borderSide: const BorderSide(color: Appcolor.lightGrey),
  //           ),
  //           focusedBorder: OutlineInputBorder(
  //             borderSide: const BorderSide(color: Appcolor.lightGrey),
  //             borderRadius: BorderRadius.circular(10),
  //           ),
  //           errorBorder: OutlineInputBorder(
  //             borderRadius: BorderRadius.circular(10),
  //             borderSide: const BorderSide(color: Colors.red),
  //           ),
  //         ),
  //         items: items,
  //         onChanged: (value) => provider.setBloodType(value!),
  //       );
  //     },
  //   );
  // }

  Widget _dividerRow() {
    return const Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Expanded(child: Divider(color: Appcolor.mediaiuGrey)),
        Text("  Or  "),
        Expanded(child: Divider(color: Appcolor.mediaiuGrey)),
      ],
    );
  }

  Widget _signInWithGoogle({required Size size}) {
    return Container(
      height: size.height * 0.07,
      width: size.width * 0.2,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(12),
        color: Appcolor.lightGrey,
      ),
      child: Center(
        child: SvgPicture.asset(
          AppImages.google,
          fit: BoxFit.contain,
          height: size.height * 0.03,
          width: size.width * 0.05,
        ),
      ),
    );
  }

  Widget _moveToLoginPage({required BuildContext context}) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        const Text("Dont have an account? "),
        TextButton(
          onPressed: () => navigateTo(context, const SignInPage()),
          child: const Text(
            "Sign Up",
            style: TextStyle(color: Appcolor.primaryColor),
          ),
        ),
      ],
    );
  }
}
