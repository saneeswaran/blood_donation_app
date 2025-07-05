import 'dart:convert';

import 'package:blood_donation/core/color/appcolor.dart';
import 'package:blood_donation/core/constants/constants.dart';
import 'package:blood_donation/features/form/model/state_model.dart';
import 'package:blood_donation/features/widgets/custom_text_formfield.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:provider/provider.dart';

class DonorUiController extends ChangeNotifier {
  List<StateDistrictModel> _allStates = [];
  List<StateDistrictModel> get allStates => _allStates;
  //donor helper
  // blood types
  List<String> bloodTypes = ['A+', 'A-', 'B+', 'B-', 'AB+', 'AB-', 'O+', 'O-'];

  String? _bloodType;

  String? get bloodTypeValue => _bloodType;

  void setBloodType(String value) {
    _bloodType = value;
    notifyListeners();
  }

  //has croncic disease
  List<String> hasChronicDisease = ['Yes', 'No'];
  String? _chronicDisease;

  String? get hasChronicDiseaseValue => _chronicDisease;

  void setChronicDisease(String value) {
    _chronicDisease = value;
    notifyListeners();
  }

  //gender
  List<String> genderList = ["Male", "Female", "Other"];
  String? _gender;

  String? get gender => _gender;

  void setGender(String value) {
    _gender = value;
    notifyListeners();
  }

  //city picker
  String? _countryValue;
  String? _stateValue;
  String? _cityValue;

  String? get countryValue => _countryValue;
  String? get stateValue => _stateValue;
  String? get cityValue => _cityValue;

  void setCity(String value) {
    _cityValue = value;
    notifyListeners();
  }

  void setState(String value) {
    _stateValue = value;
    notifyListeners();
  }

  void setCountry(String value) {
    _countryValue = value;
    notifyListeners();
  }

  Future<List<StateDistrictModel>> loadStateDistrictData() async {
    final String jsonStr = await rootBundle.loadString(AppData.states);
    final data = json.decode(jsonStr) as Map<String, dynamic>;
    final List states = data['states'];
    _allStates = states.map((e) => StateDistrictModel.fromMap(e)).toList();
    return _allStates;
  }

  //date picker
  DateTime? _selectedDate;
  DateTime? get selectedDate => _selectedDate;

  void setDate(DateTime value) {
    _selectedDate = value;
    notifyListeners();
  }

  //terms and conditions
  bool _isAccepted = false;

  bool get isAccepted => _isAccepted;

  void setAccepted(bool value) {
    _isAccepted = value;
    notifyListeners();
  }

  //widgets

  Widget genderDropDown() {
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

  Widget cronicDisease() {
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

  Widget dobPicker({required TextEditingController controller}) {
    return Consumer<DonorUiController>(
      builder: (context, provider, child) {
        return GestureDetector(
          onTap: () async {
            DateTime? pickedDate = await showDatePicker(
              context: context,
              firstDate: DateTime(1900),
              lastDate: DateTime.now(),
              initialDate: provider.selectedDate ?? DateTime(2000),
            );

            if (pickedDate != null) {
              provider.setDate(pickedDate);

              controller.text =
                  "${pickedDate.day.toString().padLeft(2, '0')}-${pickedDate.month.toString().padLeft(2, '0')}-${pickedDate.year}";
            }
          },
          child: AbsorbPointer(
            child: CustomTextFormfield(
              hintText: "Date of Birth",
              controller: controller,
            ),
          ),
        );
      },
    );
  }

  Widget bloodType() {
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
}
