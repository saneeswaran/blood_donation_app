import 'package:blood_donation/features/form/model/donor_model.dart';
import 'package:blood_donation/features/widgets/custom_snack_bar.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class DonorRepo extends ChangeNotifier {
  //
  final CollectionReference collectionReference = FirebaseFirestore.instance
      .collection('donors');
  String getCurrentUser() => FirebaseAuth.instance.currentUser!.uid;
  List<DonorModel> _allDonor = [];
  List<DonorModel> get allDonor => _allDonor;

  List<DonorModel> _filterDonor = [];
  List<DonorModel> get filterDonor => _filterDonor;

  //loading
  bool _isLoading = false;
  bool get isLoading => _isLoading;

  void setLoading(bool value) {
    _isLoading = value;
    notifyListeners();
  }

  Future<bool> addDonor({
    required BuildContext context,
    required String name,
    required int age,
    required String gender,
    required DateTime dob,
    required String bloodGroup,
    required String phone,
    required String email,
    required String address,
    required String city,
    required String state,
    required String pinCode,
    required DateTime lastDonationDate,
    required bool hasDonatedBefore,
    required int weight,
    required bool hasChronicDisease,
    required bool isOnMedication,
    required bool isAvailable,
    required bool acceptedTerms,
    required String bloodType,
  }) async {
    try {
      setLoading(true);
      final docRef = collectionReference.doc();
      //donor model
      final DonorModel donorModel = DonorModel(
        id: docRef.id,
        donorId: getCurrentUser(),
        bloodType: bloodType,
        name: name,
        age: age,
        gender: gender,
        dob: dob,
        bloodGroup: bloodGroup,
        phone: phone,
        email: email,
        address: address,
        city: city,
        state: state,
        pinCode: pinCode,
        hasChronicDisease: hasChronicDisease,
        acceptedTerms: acceptedTerms,
      );

      await docRef.set(donorModel.toMap());
      _allDonor.add(donorModel);
      _filterDonor = _allDonor;
      setLoading(false);
      notifyListeners();
      return true;
    } catch (e) {
      setLoading(false);
      if (context.mounted) {
        failedSnackBar(message: e.toString(), context: context);
      }
    }
    return false;
  }

  Future<List<DonorModel>> getAllDonors({required BuildContext context}) async {
    try {
      setLoading(true);
      final QuerySnapshot querySnapshot = await collectionReference.get();
      _allDonor = querySnapshot.docs
          .map((e) => DonorModel.fromMap(e as Map<String, dynamic>))
          .toList();
      _filterDonor = _allDonor;
      setLoading(false);
      notifyListeners();
      return _allDonor;
    } catch (e) {
      setLoading(false);
      if (context.mounted) {
        failedSnackBar(message: e.toString(), context: context);
      }
    }
    return _allDonor;
  }

  Future<bool> deleteDonor({required BuildContext context}) async {
    try {
      setLoading(true);
      final QuerySnapshot querySnapshot = await collectionReference
          .where("donorId", isEqualTo: getCurrentUser())
          .get();
      if (querySnapshot.docs.isNotEmpty) {
        await querySnapshot.docs.first.reference.delete();
        setLoading(false);
        notifyListeners();
        return true;
      }
    } catch (e) {
      setLoading(false);
      if (context.mounted) {
        failedSnackBar(message: e.toString(), context: context);
      }
    }
    return false;
  }
}
