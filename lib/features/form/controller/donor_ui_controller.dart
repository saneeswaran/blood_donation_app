import 'dart:convert';
import 'dart:io';

import 'package:blood_donation/core/color/appcolor.dart';
import 'package:blood_donation/core/constants/constants.dart';
import 'package:blood_donation/core/util/util.dart';
import 'package:blood_donation/features/form/model/state_model.dart';
import 'package:blood_donation/features/widgets/custom_text_formfield.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:image_picker/image_picker.dart';
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

  int calculateAge(DateTime dob) {
    final today = DateTime.now();
    int age = today.year - dob.year;
    if (today.month < dob.month ||
        (today.month == dob.month && today.day < dob.day)) {
      age--;
    }
    return age;
  }

  //terms and conditions
  bool _isAccepted = false;

  bool get isAccepted => _isAccepted;

  void setAccepted(bool value) {
    _isAccepted = value;
    notifyListeners();
  }

  //states
  String? _selectedState;
  String? _selectedCity;

  String? get selectedState => _selectedState;
  String? get selectedCity => _selectedCity;

  void setStateValue(String value) {
    _selectedState = value;
    notifyListeners();
  }

  void setCityValue(String value) {
    _selectedCity = value;
    notifyListeners();
  }

  //terms and conditions
  bool _accestedTerms = false;

  bool get accestedTerms => _accestedTerms;

  void setAccestedTerms(bool value) {
    _accestedTerms = value;
    notifyListeners();
  }

  //images
  File? _imageFile;
  File? get imageFile => _imageFile;

  void pickImageFromCamera({required BuildContext context}) async {
    final pickedFile = await imagePickerFromSource(
      context: context,
      imageSource: ImageSource.camera,
    );
    _imageFile = pickedFile;
    if (context.mounted) Navigator.pop(context);
    notifyListeners();
  }

  void pickImagefromGallery({required BuildContext context}) async {
    final pickedFile = await imagePickerFromSource(
      context: context,
      imageSource: ImageSource.gallery,
    );
    _imageFile = pickedFile;
    if (context.mounted) Navigator.pop(context);
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

  Widget termsAndConditions() {
    return Consumer<DonorUiController>(
      builder: (context, provider, child) {
        return Checkbox(
          value: _isAccepted,
          onChanged: (value) => provider.setAccepted(value!),
          activeColor: Appcolor.primaryColor,
        );
      },
    );
  }

  //dialog
  void showDialog({required BuildContext context, required Size size}) {
    dialog(
      context: context,
      title: "Select Image",
      content: Container(
        color: Colors.white,
        height: size.height * 0.17,
        width: size.width * 0.8,
        child: Column(
          children: [
            ListTile(
              leading: const Icon(
                Icons.camera_alt,
                color: Appcolor.mediaiuGrey,
              ),
              onTap: () {
                pickImageFromCamera(context: context);
              },
              title: const Text(
                "Camera",
                style: TextStyle(
                  color: Colors.black,
                  fontSize: 14,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
            ListTile(
              leading: const Icon(Icons.photo, color: Appcolor.mediaiuGrey),
              title: const Text(
                "Gallery",
                style: TextStyle(
                  color: Colors.black,
                  fontSize: 14,
                  fontWeight: FontWeight.bold,
                ),
              ),
              onTap: () {
                pickImagefromGallery(context: context);
              },
            ),
          ],
        ),
      ),
    );
  }
}
