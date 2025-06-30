import 'dart:convert';

import 'package:blood_donation/core/constants/constants.dart';
import 'package:blood_donation/features/form/model/state_model.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter/widgets.dart';

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
}
