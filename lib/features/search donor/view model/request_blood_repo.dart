import 'package:blood_donation/features/search%20donor/model/request_model.dart';
import 'package:blood_donation/features/widgets/custom_snack_bar.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

class RequestBloodRepo extends ChangeNotifier {
  //ref
  final CollectionReference collectionReference = FirebaseFirestore.instance
      .collection('requestBlood');

  //var
  List<RequestModel> _allRequest = [];
  List<RequestModel> _filterRequest = [];

  //getter
  List<RequestModel> get allRequest => _allRequest;
  List<RequestModel> get filterRequest => _filterRequest;

  //loader

  bool _isLoading = false;
  bool get isLoading => _isLoading;

  void setLoading(bool value) {
    _isLoading = value;
    notifyListeners();
  }

  Future<List<RequestModel>> getAllRequest({
    required BuildContext context,
  }) async {
    try {
      final QuerySnapshot querySnapshot = await collectionReference.get();
      _allRequest = querySnapshot.docs
          .map((e) => RequestModel.fromMap(e.data() as Map<String, dynamic>))
          .toList();
      _filterRequest = _allRequest;
      notifyListeners();
    } catch (e) {
      if (context.mounted) {
        failedSnackBar(message: e.toString(), context: context);
      }
    }
    return _allRequest;
  }

  Future<bool> giveBloodRequest({
    required BuildContext context,
    required String name,
    required String bloodGroup,
    required String phone,
    required String email,
    required String address,
    required String city,
    required String state,
    required String pinCode,
    required String bloodType,
    required DateTime date,
  }) async {
    try {
      //loader
      setLoading(true);
      //doc ref
      final DocumentReference docRef = collectionReference.doc();

      //model
      final RequestModel requestModel = RequestModel(
        reqId: docRef.id,
        name: name,
        bloodGroup: bloodGroup,
        phone: phone,
        email: email,
        address: address,
        city: city,
        state: state,
        pinCode: pinCode,
        bloodType: bloodType,
        date: date,
      );

      //update
      await docRef.set(requestModel.toMap());
      setLoading(false);
      return true;
    } catch (e) {
      setLoading(false);
      if (context.mounted) {
        failedSnackBar(message: e.toString(), context: context);
      }
      return false;
    }
  }
}
