import 'package:flutter/widgets.dart';

class DonorUiController extends ChangeNotifier {
  //donor helper
  // blood types
  List<String> bloodTypes = ['A+', 'A-', 'B+', 'B-', 'AB+', 'AB-', 'O+', 'O-'];

  String? type;

  void setBloodType(String value) {
    type = value;
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
}
