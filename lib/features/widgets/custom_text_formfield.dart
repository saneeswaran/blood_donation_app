import 'package:blood_donation/core/color/appcolor.dart';
import 'package:flutter/material.dart';

class CustomTextFormfield extends StatelessWidget {
  final String hintText;
  final TextEditingController controller;
  final bool? obScureText;
  final Widget? suffixIcon;
  final Widget? prefixIcon;
  final TextInputType? keyboardType;
  final int? maxLines;
  final int? maxLength;
  const CustomTextFormfield({
    super.key,
    required this.hintText,
    required this.controller,
    this.suffixIcon,
    this.obScureText,
    this.keyboardType,
    this.prefixIcon,
    this.maxLines,
    this.maxLength,
  });

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      controller: controller,
      obscureText: obScureText ?? false,
      maxLines: maxLines,
      maxLength: maxLength,
      validator: (value) {
        if (value == null || value.isEmpty) {
          return "Please Enter $hintText";
        }
        return null;
      },
      keyboardType: keyboardType,
      decoration: InputDecoration(
        hintText: hintText,
        filled: true,
        suffixIcon: suffixIcon,
        prefixIcon: prefixIcon,
        fillColor: Appcolor.lightGrey,
        counterText: "",
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
