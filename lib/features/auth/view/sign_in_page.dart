import 'package:blood_donation/core/color/appcolor.dart';
import 'package:blood_donation/core/constants/constants.dart';
import 'package:blood_donation/core/util/util.dart';
import 'package:blood_donation/features/auth/view%20model/auth_repo.dart';
import 'package:blood_donation/features/auth/view/sign_up_page.dart';
import 'package:blood_donation/features/bottom%20nav%20bar/view/bottom_nav_bar.dart';
import 'package:blood_donation/features/widgets/custom_elevated_button.dart';
import 'package:blood_donation/features/widgets/custom_text_formfield.dart';
import 'package:blood_donation/features/widgets/loader.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:provider/provider.dart';

class SignInPage extends StatefulWidget {
  const SignInPage({super.key});

  @override
  State<SignInPage> createState() => _SignInPageState();
}

class _SignInPageState extends State<SignInPage> {
  final emailController = TextEditingController();
  final passwordController = TextEditingController();
  final formKey = GlobalKey<FormState>();

  @override
  void dispose() {
    emailController.dispose();
    passwordController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;

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
                SizedBox(height: size.height * 0.1),
                const Text(
                  "Sign In Your Account",
                  style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold),
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
                SizedBox(height: size.height * 0.04),
                Consumer<AuthRepo>(
                  builder: (context, provider, child) {
                    return SizedBox(
                      height: size.height * 0.07,
                      width: double.infinity,
                      child: CustomElevatedButton(
                        onPressed: _handleLogin,
                        child: provider.isLoading
                            ? const Loader()
                            : const Text(
                                "Sign In",
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
                _moveToSignUpPage(context: context),
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

  Widget _moveToSignUpPage({required BuildContext context}) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        const Text("Don’t have an account? "),
        TextButton(
          onPressed: () => navigateTo(context, const SignUpPage()),
          child: const Text(
            "Sign Up",
            style: TextStyle(color: Appcolor.primaryColor),
          ),
        ),
      ],
    );
  }

  Future<void> _handleLogin() async {
    final provider = Provider.of<AuthRepo>(context, listen: false);

    if (!formKey.currentState!.validate()) return;

    final isSuccess = await provider.login(
      context: context,
      email: emailController.text.trim(),
      password: passwordController.text.trim(),
    );

    if (isSuccess && mounted) {
      navigateAndFinish(context, const BottomNavBar());
    }
  }
}
