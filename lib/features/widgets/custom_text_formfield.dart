import 'package:blood_donation/core/color/appcolor.dart';
import 'package:flutter/material.dart';

class CustomTextFormfield extends StatelessWidget {
  final String hintText;
  final TextEditingController controller;
  final bool? obScureText;
  final Widget? suffixIcon;
  final TextInputType? keyboardType;
  const CustomTextFormfield({
    super.key,
    required this.hintText,
    required this.controller,
    this.suffixIcon,
    this.obScureText,
    this.keyboardType,
  });

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      controller: controller,
      obscureText: obScureText ?? false,
      validator: (value) => value!.isEmpty ? "Please Enter $hintText" : null,
      keyboardType: keyboardType,
      decoration: InputDecoration(
        hintText: hintText,
        filled: true,
        suffixIcon: suffixIcon,
        fillColor: Appcolor.lightGrey,
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(10),
          borderSide: const BorderSide(color: Appcolor.lightGrey),
        ),
        focusedBorder: OutlineInputBorder(
          borderSide: const BorderSide(color: Appcolor.lightGrey),
          borderRadius: BorderRadius.circular(10),
        ),
        errorBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(10),
          borderSide: const BorderSide(color: Colors.red),
        ),
      ),
    );
  }
}
