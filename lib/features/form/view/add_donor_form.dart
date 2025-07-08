import 'package:blood_donation/core/color/appcolor.dart';
import 'package:blood_donation/features/form/controller/donor_ui_controller.dart';
import 'package:blood_donation/features/form/controller/google_map_provider.dart';
import 'package:blood_donation/features/form/view%20model/donor_repo.dart';
import 'package:blood_donation/features/form/view%20model/state_district_provider.dart';
import 'package:blood_donation/features/widgets/custom_elevated_button.dart';
import 'package:blood_donation/features/widgets/custom_snack_bar.dart';
import 'package:blood_donation/features/widgets/custom_text_formfield.dart';
import 'package:dropdown_search/dropdown_search.dart';
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
  void initState() {
    super.initState();
    context.read<StateDistrictProvider>().loadStateDistrictData();
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
                stateDropDownButton(),
                _district(),
                const SizedBox(height: 10),
                const SizedBox(height: 20),
                SizedBox(
                  width: size.width,
                  height: size.height * 0.07,
                  child:
                      Consumer4<
                        DonorRepo,
                        DonorUiController,
                        GoogleMapProvider,
                        StateDistrictProvider
                      >(
                        builder:
                            (
                              context,
                              provider,
                              uiController,
                              googleMapProvider,
                              stateDistrictProvider,
                              _,
                            ) {
                              return CustomElevatedButton(
                                onPressed: () async {
                                  if (formKey.currentState!.validate()) {
                                    if (stateDistrictProvider
                                                .selectedDistrict ==
                                            null ||
                                        stateDistrictProvider.selectedState ==
                                            null) {
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
                                      city: stateDistrictProvider
                                          .selectedDistrict!,
                                      state:
                                          stateDistrictProvider.selectedState!,
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

  Widget stateDropDownButton() {
    return Consumer<StateDistrictProvider>(
      builder: (context, provider, child) {
        return DropdownSearch<String>(
          selectedItem: provider.selectedState,
          items: (filter, loadProps) {
            if (filter.isEmpty) {
              return provider.states;
            } else {
              return provider.states
                  .where(
                    (element) =>
                        element.toLowerCase().contains(filter.toLowerCase()),
                  )
                  .toList();
            }
          },
          popupProps: const PopupProps.menu(showSearchBox: true),
          onChanged: (value) => provider.setSelectedState(value),
          decoratorProps: DropDownDecoratorProps(
            decoration: InputDecoration(
              filled: true,
              fillColor: Appcolor.lightGrey,
              hintText: "Select State",
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
          ),
        );
      },
    );
  }

  Widget _district() {
    return Consumer<StateDistrictProvider>(
      builder: (context, provider, child) {
        return DropdownSearch<String>(
          selectedItem: provider.selectedDistrict,
          items: (filter, _) {
            if (filter.isEmpty) {
              return provider.districts;
            } else {
              return provider.districts
                  .where((e) => e.toLowerCase().contains(filter.toLowerCase()))
                  .toList();
            }
          },
          popupProps: const PopupProps.menu(showSearchBox: true),
          onChanged: (value) => provider.setSelectedDistrict(value),
          decoratorProps: DropDownDecoratorProps(
            decoration: InputDecoration(
              hintText: "Select District",
              fillColor: Appcolor.lightGrey,
              filled: true,
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(10),
                borderSide: const BorderSide(color: Appcolor.lightGrey),
              ),
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
          ),
        );
      },
    );
  }
}
