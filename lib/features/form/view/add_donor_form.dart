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
  final mobileNumberController = TextEditingController();
  final ageController = TextEditingController();
  final phoneNumberController = TextEditingController();
  final dobController = TextEditingController();

  //
  String? selectedDistrict;
  String? selectedState;

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
              context.read<DonorUiController>().bloodType(),
              context.read<DonorUiController>().cronicDisease(),
              context.read<DonorUiController>().genderDropDown(),
              context.read<DonorUiController>().dobPicker(
                controller: dobController,
              ),
              StateDistrictDropdown(
                selectedDistrict: selectedDistrict,
                selectedState: selectedState,
              ),
              SizedBox(
                height: size.height * 0.07,
                width: size.width * 1,
                child:
                    Consumer3<DonorRepo, DonorUiController, GoogleMapProvider>(
                      builder:
                          (
                            context,
                            provider,
                            uiController,
                            googleMapProvider,
                            child,
                          ) {
                            return CustomElevatedButton(
                              onPressed: () async {
                                final isSuccess = await provider.addDonor(
                                  context: context,
                                  name: nameController.text,
                                  age: int.parse(ageController.text),
                                  gender: uiController.gender!,
                                  dob: uiController.selectedDate!,
                                  bloodGroup: uiController.bloodTypeValue!,
                                  phone: phoneNumberController.text,
                                  email: emailController.text,
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
    );
  }
}
