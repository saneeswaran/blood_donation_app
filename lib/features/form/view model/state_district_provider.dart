import 'dart:convert';
import 'package:blood_donation/core/color/appcolor.dart';
import 'package:blood_donation/core/constants/constants.dart';
import 'package:dropdown_search/dropdown_search.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:provider/provider.dart';
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

  Widget district() {
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
