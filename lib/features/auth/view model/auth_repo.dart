import 'package:blood_donation/features/auth/model/user_model.dart';
import 'package:blood_donation/features/form/model/donor_model.dart';
import 'package:blood_donation/features/widgets/custom_snack_bar.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';

class AuthRepo extends ChangeNotifier {
  final CollectionReference collectionReference = FirebaseFirestore.instance
      .collection('users');
  final FirebaseAuth firebaseAuth = FirebaseAuth.instance;
  //eye button
  //show password
  bool _isShowPassword = false;
  bool get isShowPassword => _isShowPassword;

  void showPassword() {
    _isShowPassword = !_isShowPassword;
    notifyListeners();
  }

  //show confirm password
  bool _isShowConfirmPassword = false;
  bool get isShowConfirmPassword => _isShowConfirmPassword;
  void showConfirmPassword() {
    _isShowConfirmPassword = !_isShowConfirmPassword;
    notifyListeners();
  }

  //checkbox
  bool _checkBoxClicked = false;
  bool get checkBoxClicked => _checkBoxClicked;
  void setCheckBoxClicked() {
    _checkBoxClicked = !_checkBoxClicked;
    notifyListeners();
  }

  //login functions
  bool _isloading = false;
  bool get isLoading => _isloading;

  void setLoading(bool value) {
    _isloading = value;
    notifyListeners();
  }

  Future<bool> register({
    required BuildContext context,
    required String name,
    required String email,
    required String password,
  }) async {
    try {
      setLoading(true);
      await firebaseAuth.createUserWithEmailAndPassword(
        email: email,
        password: password,
      );
      //uid
      final String authId = firebaseAuth.currentUser!.uid;
      //doc ref
      final userRef = collectionReference.doc();
      //fcm
      final String? fcmToken = await FirebaseMessaging.instance.getToken();
      //user model
      final UserModel userModel = UserModel(
        id: userRef.id,
        name: name,
        email: email,
        fcmToken: fcmToken,
        authId: authId,
      );
      await userRef.set(userModel.toMap());
      setLoading(false);
      notifyListeners();
      return true;
    } catch (e) {
      if (context.mounted) {
        setLoading(false);
        failedSnackBar(message: e.toString(), context: context);
      }
    }
    return false;
  }

  Future<bool> login({
    required BuildContext context,
    required String email,
    required String password,
  }) async {
    try {
      setLoading(true);

      // Sign in the user
      await firebaseAuth.signInWithEmailAndPassword(
        email: email,
        password: password,
      );

      final String authId = firebaseAuth.currentUser!.uid;

      // Get FCM token
      final String? fcmToken = await FirebaseMessaging.instance.getToken();

      final querySnapshot = await collectionReference
          .where('authId', isEqualTo: authId)
          .limit(1)
          .get();

      if (querySnapshot.docs.isNotEmpty) {
        final userDoc = querySnapshot.docs.first.reference;
        await userDoc.update({'fcmToken': fcmToken});
      }

      setLoading(false);
      notifyListeners();
      return true;
    } catch (e) {
      if (context.mounted) {
        setLoading(false);
        failedSnackBar(message: e.toString(), context: context);
      }
      return false;
    }
  }

  void logout() async {
    await firebaseAuth.signOut();
    notifyListeners();
  }

  //check user become donor
  bool _isDonor = false;
  bool get isDonor => _isDonor;

  //avoid again and again fetch

  bool _isDonorFetched = false;
  bool get isDonorFetched => _isDonorFetched;

  Future<void> checkUserBecomeDonor({required BuildContext context}) async {
    try {
      if (_isDonorFetched) return;
      final currentUser = firebaseAuth.currentUser!.uid;
      final CollectionReference donorCollection = FirebaseFirestore.instance
          .collection('donors');
      final QuerySnapshot querySnapshot = await donorCollection
          .where("authId", isEqualTo: currentUser)
          .get();
      querySnapshot.docs
          .map((e) => DonorModel.fromMap(e.data() as Map<String, dynamic>))
          .toList();
      if (querySnapshot.docs.isNotEmpty) {
        _isDonor = true;
      } else {
        _isDonor = false;
      }
      _isDonorFetched = true;
      notifyListeners();
    } catch (e) {
      if (context.mounted) {
        failedSnackBar(message: e.toString(), context: context);
      }
    }
  }
}
