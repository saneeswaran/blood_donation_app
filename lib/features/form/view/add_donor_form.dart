import 'package:blood_donation/core/color/appcolor.dart';
import 'package:blood_donation/features/form/controller/donor_ui_controller.dart';
import 'package:blood_donation/features/widgets/custom_text_formfield.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class AddDonorForm extends StatefulWidget {
  const AddDonorForm({super.key});

  @override
  State<AddDonorForm> createState() => _AddDonorFormState();
}

class _AddDonorFormState extends State<AddDonorForm> {
  final formKey = GlobalKey<FormState>();
  final nameController = TextEditingController();
  final gmailController = TextEditingController();
  final mobileNumberController = TextEditingController();
  final ageController = TextEditingController();
  final phoneNumberController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    final Size size = MediaQuery.of(context).size;
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.all(20.0),
        child: SingleChildScrollView(
          child: Column(
            spacing: size.height * 0.02,
            children: [
              const SizedBox(height: 20),
              const Text(
                "Become a Donor",
                style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold),
              ),
              CustomTextFormfield(hintText: "Name", controller: nameController),
              CustomTextFormfield(
                hintText: "Email",
                controller: gmailController,
              ),
              CustomTextFormfield(
                hintText: "Age",
                controller: ageController,
                maxLines: 2,
              ),
              CustomTextFormfield(
                hintText: "+ 91",
                controller: phoneNumberController,
                maxLines: 10,
                keyboardType: TextInputType.number,
              ),
              _bloodType(),
              _cronicDisease(),
              _genderDropDown(),
            ],
          ),
        ),
      ),
    );
  }

  Widget _bloodType() {
    return Consumer<DonorUiController>(
      builder: (context, provider, child) {
        final items = provider.bloodTypes
            .map((e) => DropdownMenuItem(value: e, child: Text(e)))
            .toList();
        return DropdownButtonFormField(
          hint: const Text(
            "Select Blood Type",
            style: TextStyle(color: Colors.grey),
          ),
          decoration: InputDecoration(
            filled: true,
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
          items: items,
          onChanged: (value) => provider.setBloodType(value!),
        );
      },
    );
  }

  Widget _cronicDisease() {
    return Consumer<DonorUiController>(
      builder: (context, provider, child) {
        final items = provider.hasChronicDisease
            .map((e) => DropdownMenuItem(value: e, child: Text(e)))
            .toList();
        return DropdownButtonFormField(
          hint: const Text(
            "Has Chronic Disease ?",
            style: TextStyle(color: Colors.grey),
          ),
          decoration: InputDecoration(
            filled: true,
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
          items: items,
          onChanged: (value) => provider.setChronicDisease(value!),
        );
      },
    );
  }

  Widget _genderDropDown() {
    return Consumer<DonorUiController>(
      builder: (context, provider, child) {
        final items = provider.genderList
            .map((e) => DropdownMenuItem(value: e, child: Text(e)))
            .toList();
        return DropdownButtonFormField(
          decoration: InputDecoration(
            hint: const Text(
              "Select Gender",
              style: TextStyle(color: Colors.grey),
            ),
            filled: true,
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
          items: items,
          onChanged: (value) => provider.setGender(value!),
        );
      },
    );
  }
}
