import 'dart:developer';

import 'package:blood_donation/core/color/appcolor.dart';
import 'package:blood_donation/core/constants/constants.dart';
import 'package:blood_donation/core/util/util.dart';
import 'package:blood_donation/features/auth/view%20model/auth_repo.dart';
import 'package:blood_donation/features/auth/view/sign_in_page.dart';
import 'package:blood_donation/features/bottom%20nav%20bar/view/bottom_nav_bar.dart';
import 'package:blood_donation/features/widgets/custom_elevated_button.dart';
import 'package:blood_donation/features/widgets/custom_snack_bar.dart';
import 'package:blood_donation/features/widgets/custom_text_formfield.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:provider/provider.dart';

class SignUpPage extends StatefulWidget {
  const SignUpPage({super.key});

  @override
  State<SignUpPage> createState() => _SignUpPageState();
}

class _SignUpPageState extends State<SignUpPage> {
  final nameController = TextEditingController();
  final emailController = TextEditingController();
  final passwordController = TextEditingController();
  final confirmPasswordController = TextEditingController();
  final formKey = GlobalKey<FormState>();

  @override
  void dispose() {
    nameController.dispose();
    emailController.dispose();
    passwordController.dispose();
    confirmPasswordController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final Size size = MediaQuery.of(context).size;

    return Scaffold(
      appBar: AppBar(backgroundColor: Appcolor.scaffoldBackgroundColor),
      body: Padding(
        padding: const EdgeInsets.all(20),
        child: SingleChildScrollView(
          keyboardDismissBehavior: ScrollViewKeyboardDismissBehavior.onDrag,
          child: Form(
            key: formKey,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                SizedBox(height: size.height * 0.03),
                const Text(
                  "Sign Up Your Account",
                  style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold),
                ),
                SizedBox(height: size.height * 0.04),
                CustomTextFormfield(
                  hintText: "Username",
                  controller: nameController,
                ),
                SizedBox(height: size.height * 0.02),
                CustomTextFormfield(
                  hintText: "Email",
                  controller: emailController,
                  keyboardType: TextInputType.emailAddress,
                ),
                SizedBox(height: size.height * 0.02),
                Consumer<AuthRepo>(
                  builder: (context, provider, child) {
                    return CustomTextFormfield(
                      hintText: "Password",
                      controller: passwordController,
                      obScureText: !provider.isShowPassword,
                      suffixIcon: IconButton(
                        onPressed: () => provider.showPassword(),
                        icon: Icon(
                          provider.isShowPassword
                              ? Icons.visibility
                              : Icons.visibility_off,
                        ),
                      ),
                    );
                  },
                ),
                SizedBox(height: size.height * 0.02),
                Consumer<AuthRepo>(
                  builder: (context, provider, child) {
                    return CustomTextFormfield(
                      hintText: "Confirm Password",
                      controller: confirmPasswordController,
                      obScureText: !provider.isShowConfirmPassword,

                      suffixIcon: IconButton(
                        onPressed: () => provider.showConfirmPassword(),
                        icon: Icon(
                          provider.isShowConfirmPassword
                              ? Icons.visibility
                              : Icons.visibility_off,
                        ),
                      ),
                    );
                  },
                ),
                SizedBox(height: size.height * 0.02),
                _checkBox(),
                SizedBox(height: size.height * 0.04),
                Consumer<AuthRepo>(
                  builder: (context, provider, child) {
                    return SizedBox(
                      height: size.height * 0.07,
                      width: double.infinity,
                      child: CustomElevatedButton(
                        onPressed: _register,
                        child: provider.isLoading
                            ? const CircularProgressIndicator.adaptive(
                                backgroundColor: Colors.white,
                              )
                            : const Text(
                                "Sign Up",
                                style: TextStyle(color: Colors.white),
                              ),
                      ),
                    );
                  },
                ),
                SizedBox(height: size.height * 0.03),
                _dividerRow(),
                SizedBox(height: size.height * 0.03),
                Center(child: _signInWithGoogle(size: size)),
                SizedBox(height: size.height * 0.03),
                _moveToLoginPage(context: context),
              ],
            ),
          ),
        ),
      ),
    );
  }

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

  Widget _checkBox() {
    return Row(
      children: [
        Consumer<AuthRepo>(
          builder: (context, provider, child) {
            final value = provider.checkBoxClicked;
            return Checkbox(
              activeColor: Appcolor.primaryColor,
              value: value,
              onChanged: (value) => provider.setCheckBoxClicked(),
            );
          },
        ),
        const Text("I agree with the terms and conditions"),
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
        const Text("Already have an account?"),
        TextButton(
          onPressed: () => navigateTo(context, const SignInPage()),
          child: const Text(
            "Sign In",
            style: TextStyle(color: Appcolor.primaryColor),
          ),
        ),
      ],
    );
  }

  Future<void> _register() async {
    final provider = Provider.of<AuthRepo>(context, listen: false);
    if (!formKey.currentState!.validate()) return;
    if (passwordController.text.trim() !=
        confirmPasswordController.text.trim()) {
      failedSnackBar(context: context, message: "Passwords do not match");
      log("Passwords do not match");
      return;
    }
    if (provider.checkBoxClicked == false) {
      failedSnackBar(
        context: context,
        message: "Please accept terms and conditions",
      );
      log("Please accept terms and conditions");
    }
    final isSuccess = await provider.register(
      context: context,
      name: nameController.text,
      email: emailController.text,
      password: passwordController.text,
    );
    if (isSuccess && mounted) {
      navigateAndFinish(context, const BottomNavBar());
    }
  }
}
