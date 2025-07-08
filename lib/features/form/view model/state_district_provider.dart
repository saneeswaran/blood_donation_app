import 'dart:convert';
import 'package:blood_donation/core/constants/constants.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import '../model/state_model.dart';

class StateDistrictProvider extends ChangeNotifier {
  List<StateDistrictModel> _stateDistrictList = [];
  List<String> _states = [];
  List<String> _districts = [];

  String? _selectedState;
  String? _selectedDistrict;

  List<String> get states => _states;
  List<String> get districts => _districts;

  String? get selectedState => _selectedState;
  String? get selectedDistrict => _selectedDistrict;

  Future<void> loadStateDistrictData() async {
    final jsonStr = await rootBundle.loadString(AppData.states);
    final data = json.decode(jsonStr);

    _stateDistrictList = (data['states'] as List)
        .map((e) => StateDistrictModel.fromMap(e))
        .toList();

    _states = _stateDistrictList.map((e) => e.state).toList();
    notifyListeners();
  }

  void setSelectedState(String? state) {
    _selectedState = state;
    _selectedDistrict = null;

    if (state != null) {
      final matched = _stateDistrictList.firstWhere((e) => e.state == state);
      _districts = matched.districts;
    } else {
      _districts = [];
    }

    notifyListeners();
  }

  void setSelectedDistrict(String? district) {
    _selectedDistrict = district;
    notifyListeners();
  }
}
