import 'dart:io';

import 'package:blood_donation/core/constants/constants.dart';
import 'package:blood_donation/features/auth/model/user_model.dart';
import 'package:blood_donation/features/form/model/donor_model.dart';
import 'package:blood_donation/features/widgets/custom_snack_bar.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:cloudinary_public/cloudinary_public.dart';
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

  UserModel? _userData;
  UserModel? get userData => _userData;

  void setLoading(bool value) {
    _isLoading = value;
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
    required bool acceptedTerms,
    required String bloodType,
    required File image,
  }) async {
    try {
      setLoading(true);
      final docRef = collectionReference.doc();
      //upload images
      CloudinaryPublic cloudinaryPublic = CloudinaryPublic(
        CloudinaryData.cloudName,
        CloudinaryData.cloudinaryPreset,
      );
      CloudinaryResponse response = await cloudinaryPublic.uploadFile(
        CloudinaryFile.fromFile(
          image.path,
          resourceType: CloudinaryResourceType.Image,
        ),
      );
      final imageUrl = response.secureUrl;
      //donor model
      final DonorModel donorModel = DonorModel(
        authId: getCurrentUser(),
        activeStatus: "active",
        imageUrl: imageUrl,
        id: docRef.id,
        donorId: getCurrentUser(),
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
        acceptedTerms: acceptedTerms,
        createdAt: Timestamp.now(),
      );
      await docRef.set(donorModel.toMap());
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
          .map((e) => DonorModel.fromMap(e.data() as Map<String, dynamic>))
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

  void listenDonors() {
    collectionReference.snapshots().listen((event) {
      _allDonor = event.docs
          .map((e) => DonorModel.fromMap(e.data() as Map<String, dynamic>))
          .toList();
      _filterDonor = _allDonor;
      notifyListeners();
    });
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
        _allDonor.removeWhere((e) => e.donorId == getCurrentUser());
        _filterDonor = _allDonor;
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

  Future<bool> updateDonorDetails({
    required BuildContext context,
    required String name,
    required String bloodType,
    required String donorId,
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
    required bool acceptedTerms,
    required File image,
  }) async {
    try {
      setLoading(true);
      final currentUser = FirebaseAuth.instance.currentUser!.uid;
      final doc = await collectionReference
          .where("donorId", isEqualTo: donorId)
          .get();
      //upload images
      CloudinaryPublic cloudinaryPublic = CloudinaryPublic(
        CloudinaryData.cloudName,
        CloudinaryData.cloudinaryPreset,
      );
      CloudinaryResponse response = await cloudinaryPublic.uploadFile(
        CloudinaryFile.fromFile(
          image.path,
          resourceType: CloudinaryResourceType.Image,
        ),
      );
      final imageUrl = response.secureUrl;
      final DonorModel donorModel = DonorModel(
        authId: currentUser,
        activeStatus: "active",
        imageUrl: imageUrl,
        name: name,
        donorId: donorId,
        age: age,
        gender: gender,
        dob: dob,
        bloodGroup: bloodGroup,
        phone: phone,
        email: email,
        address: address,
        city: city,
        state: state,
        acceptedTerms: acceptedTerms,
      );
      await doc.docs.first.reference.update(donorModel.toMap());
      final index = _allDonor.indexWhere((e) => e.donorId == currentUser);
      _allDonor[index] = donorModel;
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

  //update active status

  Future<bool> changeDonorActiveStatus({
    required BuildContext context,
    required String id,
    required String status,
  }) async {
    try {
      final DocumentSnapshot documentSnapshot = await collectionReference
          .where("authId", isEqualTo: id)
          .get()
          .then((value) => value.docs.first);

      if (documentSnapshot.exists) {
        await documentSnapshot.reference.update({"activeStatus": status});
      } else {
        return false;
      }
      return true;
    } catch (e) {
      if (context.mounted) {
        failedSnackBar(message: e.toString(), context: context);
      }
      return false;
    }
  }

  //ge current user Donor details
  UserModel? _currentDonor;
  UserModel? get currentDonor => _currentDonor;

  Future<UserModel> getCurrentUserData({required BuildContext context}) async {
    try {
      setLoading(true);
      final userCollectionReference = FirebaseFirestore.instance.collection(
        "users",
      );
      final DocumentSnapshot documentSnapshot = await userCollectionReference
          .where("authId", isEqualTo: getCurrentUser())
          .get()
          .then((value) => value.docs.first);

      if (documentSnapshot.exists) {
        _currentDonor = UserModel.fromMap(
          documentSnapshot.data() as Map<String, dynamic>,
        );
        setLoading(false);
        notifyListeners();
      }
    } catch (e) {
      setLoading(false);
      if (context.mounted) {
        failedSnackBar(message: e.toString(), context: context);
      }
    }
    return _currentDonor!;
  }

  List<DonorModel> filterDonorByModel({required DonorModel donor}) {
    _filterDonor = _allDonor
        .where(
          (e) =>
              e.bloodGroup.toLowerCase().contains(
                donor.bloodGroup.toLowerCase(),
              ) ||
              e.state.toLowerCase().contains(donor.state.toLowerCase()) ||
              e.city.toLowerCase().contains(donor.city.toLowerCase()),
        )
        .toList();

    notifyListeners();
    return _filterDonor;
  }

  List<DonorModel> filterWithRestricedByModel({required DonorModel donor}) {
    _filterDonor = _allDonor
        .where(
          (e) =>
              e.bloodGroup.toLowerCase().contains(
                donor.bloodGroup.toLowerCase(),
              ) &&
              e.state.toLowerCase().contains(donor.state.toLowerCase()) &&
              e.city.toLowerCase().contains(donor.city.toLowerCase()),
        )
        .toList();

    notifyListeners();
    return _filterDonor;
  }

  bool isCheckUserBecameDonor() {
    final bool isDonor = _allDonor.any((e) => e.authId == getCurrentUser());
    return isDonor;
  }
}
