import 'package:blood_donation/features/form/controller/donor_ui_controller.dart';
import 'package:blood_donation/features/form/controller/google_map_provider.dart';
import 'package:blood_donation/features/form/view%20model/donor_repo.dart';
import 'package:blood_donation/features/form/widget/state_district_dropdown.dart';
import 'package:blood_donation/features/widgets/custom_elevated_button.dart';
import 'package:blood_donation/features/widgets/custom_snack_bar.dart';
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
  final ageController = TextEditingController();
  final phoneNumberController = TextEditingController();
  final dobController = TextEditingController();

  String? selectedDistrict;
  String? selectedState;

  @override
  void dispose() {
    nameController.dispose();
    emailController.dispose();
    ageController.dispose();
    phoneNumberController.dispose();
    dobController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    final donorUI = context.read<DonorUiController>();

    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.all(20.0),
        child: SingleChildScrollView(
          child: Form(
            key: formKey,
            child: Column(
              spacing: size.height * 0.02,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const SizedBox(height: 20),
                const Center(
                  child: Text(
                    "Become a Donor",
                    style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold),
                  ),
                ),
                const SizedBox(height: 20),
                CustomTextFormfield(
                  hintText: "Name",
                  controller: nameController,
                ),
                CustomTextFormfield(
                  hintText: "Email",
                  controller: emailController,
                ),
                CustomTextFormfield(
                  hintText: "Age",
                  controller: ageController,
                  keyboardType: TextInputType.number,
                ),
                CustomTextFormfield(
                  hintText: "+91 Phone Number",
                  controller: phoneNumberController,
                  keyboardType: TextInputType.phone,
                ),
                donorUI.bloodType(),
                donorUI.cronicDisease(),
                donorUI.genderDropDown(),
                donorUI.dobPicker(controller: dobController),
                const SizedBox(height: 10),
                StateDistrictDropdown(
                  selectedState: selectedState,
                  selectedDistrict: selectedDistrict,
                ),
                const SizedBox(height: 20),
                SizedBox(
                  width: size.width,
                  height: size.height * 0.07,
                  child:
                      Consumer3<
                        DonorRepo,
                        DonorUiController,
                        GoogleMapProvider
                      >(
                        builder:
                            (
                              context,
                              provider,
                              uiController,
                              googleMapProvider,
                              _,
                            ) {
                              return CustomElevatedButton(
                                onPressed: () async {
                                  if (formKey.currentState!.validate()) {
                                    if (selectedDistrict == null ||
                                        selectedState == null) {
                                      failedSnackBar(
                                        message:
                                            "Please select state and district",
                                        context: context,
                                      );
                                      return;
                                    }

                                    final isSuccess = await provider.addDonor(
                                      context: context,
                                      name: nameController.text.trim(),
                                      age:
                                          int.tryParse(
                                            ageController.text.trim(),
                                          ) ??
                                          0,
                                      gender: uiController.gender!,
                                      dob: uiController.selectedDate!,
                                      bloodGroup: uiController.bloodTypeValue!,
                                      phone: phoneNumberController.text.trim(),
                                      email: emailController.text.trim(),
                                      address: googleMapProvider.address,
                                      bloodType: uiController.bloodTypeValue!,
                                      city: selectedDistrict!,
                                      state: selectedState!,
                                      hasChronicDisease:
                                          uiController.hasChronicDiseaseValue!,
                                      acceptedTerms: uiController.isAccepted,
                                    );

                                    if (isSuccess && context.mounted) {
                                      successSnackBar(
                                        message:
                                            "You have successfully become a Donor",
                                        context: context,
                                      );
                                    }
                                  }
                                },
                                child: const Text(
                                  "Submit",
                                  style: TextStyle(
                                    color: Colors.white,
                                    fontSize: 18,
                                  ),
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
      ),
    );
  }
}
