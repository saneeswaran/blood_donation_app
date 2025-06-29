import 'package:blood_donation/core/color/appcolor.dart';
import 'package:blood_donation/features/form/controller/donor_ui_controller.dart';
import 'package:blood_donation/features/form/view%20model/donor_repo.dart';
import 'package:blood_donation/features/form/widget/state_district_dropdown.dart';
import 'package:blood_donation/features/widgets/custom_elevated_button.dart';
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
  final emailController = TextEditingController();
  final mobileNumberController = TextEditingController();
  final ageController = TextEditingController();
  final phoneNumberController = TextEditingController();

  @override
  void dispose() {
    formKey.currentState?.dispose();
    nameController.dispose();
    emailController.dispose();
    mobileNumberController.dispose();
    ageController.dispose();
    phoneNumberController.dispose();
    super.dispose();
  }

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
                controller: emailController,
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
              const StateDistrictDropdown(),
              SizedBox(
                height: size.height * 0.07,
                width: size.width * 1,
                child: Consumer<DonorRepo>(
                  builder: (context, provider, child) {
                    return CustomElevatedButton(
                      onPressed: () async {
                        final uiController = Provider.of<DonorUiController>(
                          context,
                          listen: false,
                        );
                        final isSuccess = await provider.addDonor(
                          context: context,
                          name: nameController.text,
                          age: int.parse(ageController.text),
                          gender: provider,
                          dob: dob,
                          bloodGroup: uiController.bloodType!,
                          phone: phoneNumberController.text,
                          email: emailController.text,
                          address: address,
                          city:,
                          state: state,
                          pinCode: pinCode,
                          lastDonationDate: lastDonationDate,
                          hasDonatedBefore: hasDonatedBefore,
                          weight: weight,
                          hasChronicDisease: uiController.hasChronicDisease!,
                          acceptedTerms: acceptedTerms,
                        );
                      },
                      child: const Text(
                        "Submit",
                        style: TextStyle(color: Colors.white, fontSize: 18),
                      ),
                    );
                  },
                ),
              ),
              const SizedBox(height: 20),
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
            hintText: "Select Gender",
            hintStyle: TextStyle(color: Colors.grey.shade600),
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
