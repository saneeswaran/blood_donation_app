import 'dart:convert';
import 'package:blood_donation/core/color/appcolor.dart';
import 'package:blood_donation/core/constants/constants.dart';
import 'package:blood_donation/features/form/model/state_model.dart';
import 'package:dropdown_search/dropdown_search.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

// ignore: must_be_immutable
class StateDistrictDropdown extends StatefulWidget {
  String? selectedState;
  String? selectedDistrict;

  StateDistrictDropdown({super.key, this.selectedState, this.selectedDistrict});

  @override
  State<StateDistrictDropdown> createState() => _StateDistrictDropdownState();
}

class _StateDistrictDropdownState extends State<StateDistrictDropdown> {
  List<StateDistrictModel> _stateDistrictList = [];
  List<String> _states = [];
  List<String> _districts = [];

  @override
  void initState() {
    super.initState();
    loadStateDistrictJson();
  }

  Future<void> loadStateDistrictJson() async {
    final String jsonStr = await rootBundle.loadString(AppData.states);
    final data = json.decode(jsonStr);

    final List<StateDistrictModel> list = (data['states'] as List)
        .map((e) => StateDistrictModel.fromMap(e))
        .toList();

    setState(() {
      _stateDistrictList = list;
      _states = list.map((e) => e.state).toList();
    });
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        DropdownSearch<String>(
          decoratorProps: DropDownDecoratorProps(
            decoration: InputDecoration(
              filled: true,
              hintText: "Select State",
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
          ),
          items: (filter, loadProps) {
            if (filter.isEmpty) {
              return _states;
            } else {
              return _states
                  .where((e) => e.toLowerCase().contains(filter.toLowerCase()))
                  .toList();
            }
          },
          onChanged: (value) {
            setState(() {
              widget.selectedState = value;
              widget.selectedDistrict = null;
              _districts = _stateDistrictList
                  .firstWhere((e) => e.state == value)
                  .districts;
            });
          },
        ),

        const SizedBox(height: 20),

        DropdownSearch<String>(
          items: (filter, loadProp) {
            if (filter.isEmpty) {
              return _districts;
            } else {
              return _districts
                  .where((e) => e.toLowerCase().contains(filter.toLowerCase()))
                  .toList();
            }
          },
          selectedItem: widget.selectedDistrict,
          popupProps: const PopupProps.menu(showSearchBox: true),
          decoratorProps: DropDownDecoratorProps(
            decoration: InputDecoration(
              filled: true,
              hintText: "Select District",
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
          ),
          onChanged: (value) {
            setState(() {
              widget.selectedDistrict = value;
            });
          },
        ),
      ],
    );
  }
}
