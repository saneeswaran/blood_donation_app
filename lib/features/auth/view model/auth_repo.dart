import 'package:blood_donation/features/auth/model/user_model.dart';
import 'package:blood_donation/features/widgets/custom_snack_bar.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
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

  // blood types
  List<String> bloodTypes = ['A+', 'A-', 'B+', 'B-', 'AB+', 'AB-', 'O+', 'O-'];

  String? type;

  void setBloodType(String value) {
    type = value;
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
      final userRef = collectionReference.doc();
      //user model
      final UserModel userModel = UserModel(
        id: userRef.id,
        name: name,
        email: email,
        password: password,
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
      await firebaseAuth.signInWithEmailAndPassword(
        email: email,
        password: password,
      );
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
}
