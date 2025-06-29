import 'dart:convert';

import 'package:blood_donation/core/constants/constants.dart';
import 'package:blood_donation/features/form/model/state_model.dart';
import 'package:flutter/services.dart';
import 'package:flutter/widgets.dart';

class DonorUiController extends ChangeNotifier {
  List<StateDistrictModel> _allStates = [];
  List<StateDistrictModel> get allStates => _allStates;
  //donor helper
  // blood types
  List<String> bloodTypes = ['A+', 'A-', 'B+', 'B-', 'AB+', 'AB-', 'O+', 'O-'];

  String? bloodType;

  void setBloodType(String value) {
    bloodType = value;
    notifyListeners();
  }

  //has croncic disease
  List<String> hasChronicDisease = ['Yes', 'No'];
  String? chronicDisease;

  void setChronicDisease(String value) {
    chronicDisease = value;
    notifyListeners();
  }

  List<String> genderList = ["Male", "Female", "Other"];
  String? gender;

  void setGender(String value) {
    gender = value;
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
}
