import 'package:blood_donation/core/color/appcolor.dart';
import 'package:blood_donation/core/util/util.dart';
import 'package:blood_donation/features/form/controller/donor_ui_controller.dart';
import 'package:blood_donation/features/form/controller/google_map_provider.dart';
import 'package:blood_donation/features/form/view%20model/donor_repo.dart';
import 'package:blood_donation/features/form/view%20model/state_district_provider.dart';
import 'package:blood_donation/features/form/widget/location_picker.dart';
import 'package:blood_donation/features/form/widget/terms_and_conditions.dart';
import 'package:blood_donation/features/widgets/custom_elevated_button.dart';
import 'package:blood_donation/features/widgets/custom_snack_bar.dart';
import 'package:blood_donation/features/widgets/custom_text_formfield.dart';
import 'package:blood_donation/features/widgets/loader.dart';
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
  final phoneNumberController = TextEditingController();
  final dobController = TextEditingController();
  final addressController = TextEditingController();

  @override
  void dispose() {
    nameController.dispose();
    emailController.dispose();
    phoneNumberController.dispose();
    dobController.dispose();
    addressController.dispose();
    super.dispose();
  }

  @override
  void initState() {
    super.initState();
    final googleMapProvider = Provider.of<GoogleMapProvider>(
      context,
      listen: false,
    );

    googleMapProvider.getCurrentLocation().then((_) {
      addressController.text = googleMapProvider.address;
    });

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
                Center(
                  child: GestureDetector(
                    onTap: () {
                      donorUI.showDialog(context: context, size: size);
                    },
                    child: Consumer<DonorUiController>(
                      builder: (context, provider, child) {
                        return Container(
                          height: size.height * 0.20,
                          width: size.width * 0.6,
                          decoration: provider.imageFile == null
                              ? const BoxDecoration(
                                  color: Appcolor.lightGrey,
                                  shape: BoxShape.circle,
                                )
                              : BoxDecoration(
                                  shape: BoxShape.circle,
                                  image: DecorationImage(
                                    image: FileImage(provider.imageFile!),
                                    fit: BoxFit.cover,
                                  ),
                                ),
                          child: provider.imageFile == null
                              ? const Center(
                                  child: Text(
                                    "Please select\n your image",
                                    textAlign: TextAlign.center,
                                    style: TextStyle(
                                      color: Colors.black,
                                      fontSize: 14,
                                      fontWeight: FontWeight.bold,
                                    ),
                                  ),
                                )
                              : null,
                        );
                      },
                    ),
                  ),
                ),
                CustomTextFormfield(
                  hintText: "Name",
                  controller: nameController,
                ),
                CustomTextFormfield(
                  hintText: "Email",
                  controller: emailController,
                ),
                donorUI.dobPicker(controller: dobController),
                CustomTextFormfield(
                  hintText: "+91 Phone Number",
                  controller: phoneNumberController,
                  keyboardType: TextInputType.phone,
                  maxLength: 10,
                ),
                donorUI.bloodType(),
                //  donorUI.cronicDisease(),
                donorUI.genderDropDown(),
                _stateAndDiscrict(size: size),
                CustomTextFormfield(
                  hintText: "Address",
                  controller: addressController,
                  maxLines: 5,
                ),
                Row(
                  children: [
                    donorUI.termsAndConditions(),
                    TextButton(
                      onPressed: () =>
                          navigateTo(context, const TermsAndConditions()),
                      child: const Text(
                        "Terms and Conditions",
                        style: TextStyle(
                          color: Colors.black,
                          fontSize: 14,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 20),
                SizedBox(
                  height: size.height * 0.07,
                  width: size.width * 1,
                  child: CustomElevatedButton(
                    onPressed: () =>
                        navigateTo(context, const LocationPickerScreen()),
                    child: const Text(
                      "Pick Location",
                      style: TextStyle(color: Colors.white, fontSize: 18),
                    ),
                  ),
                ),
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
                                    if (googleMapProvider.address.isEmpty ||
                                        googleMapProvider.latitude == null ||
                                        googleMapProvider.longitude == null) {
                                      failedSnackBar(
                                        message: "Please select location",
                                        context: context,
                                      );
                                      return;
                                    }
                                    if (!uiController.isAccepted) {
                                      failedSnackBar(
                                        message:
                                            "Please accept terms and conditions",
                                        context: context,
                                      );
                                      return;
                                    }
                                    final calculatedAge = uiController
                                        .calculateAge(
                                          uiController.selectedDate!,
                                        );
                                    if (calculatedAge < 18) {
                                      failedSnackBar(
                                        message:
                                            "Age should be greater than 18",
                                        context: context,
                                      );
                                      return;
                                    }
                                    if (donorUI.imageFile == null) {
                                      failedSnackBar(
                                        message: "Please select image",
                                        context: context,
                                      );
                                      return;
                                    }

                                    final isSuccess = await provider.addDonor(
                                      context: context,
                                      name: nameController.text.trim(),
                                      gender: uiController.gender!,
                                      dob: uiController.selectedDate!,
                                      age: calculatedAge,
                                      bloodGroup: uiController.bloodTypeValue!,
                                      phone: phoneNumberController.text.trim(),
                                      email: emailController.text.trim(),
                                      address: googleMapProvider.address,
                                      bloodType: uiController.bloodTypeValue!,
                                      city: stateDistrictProvider
                                          .selectedDistrict!,
                                      state:
                                          stateDistrictProvider.selectedState!,
                                      image: donorUI.imageFile!,
                                      acceptedTerms: uiController.isAccepted,
                                    );

                                    if (isSuccess && context.mounted) {
                                      successSnackBar(
                                        message:
                                            "You have successfully become a Donor",
                                        context: context,
                                      );
                                      Navigator.pop(context);
                                    }
                                  }
                                },
                                child: provider.isLoading
                                    ? const Loader()
                                    : const Text(
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

  Widget _stateAndDiscrict({required Size size}) {
    final provider = Provider.of<StateDistrictProvider>(context, listen: false);
    return Column(
      spacing: size.height * 0.02,
      children: [provider.stateDropDownButton(), provider.district()],
    );
  }
}
