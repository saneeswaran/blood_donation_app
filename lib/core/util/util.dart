import 'dart:io';
import 'package:path/path.dart' as path;
import 'package:flutter/material.dart';
import 'package:page_transition/page_transition.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:image_picker/image_picker.dart';

void navigateTo(context, widget) => Navigator.push(
  context,
  PageTransition(
    type: PageTransitionType.rightToLeftJoined,
    childCurrent: widget,
    duration: const Duration(milliseconds: 400),
    child: widget,
  ),
);

void navigateAndFinish(context, widget) => Navigator.pushAndRemoveUntil(
  context,
  PageTransition(
    type: PageTransitionType.fade,
    duration: const Duration(milliseconds: 500),
    child: widget,
  ),
  (route) => false,
);

void dialog({
  required BuildContext context,
  required String title,
  required Widget content,
}) {
  showDialog(
    context: context,
    builder: (context) => AlertDialog(
      title: Text(
        title,
        style: const TextStyle(
          color: Colors.black,
          fontSize: 18,
          fontWeight: FontWeight.bold,
        ),
      ),
      content: content,
    ),
  );
}

String? validateEmail(String? value) {
  String pattern =
      r'^(([^<>()[\]\\.,;:\s@\"]+(\.[^<>()[\]\\.,;:\s@\"]+)*)|(\".+\"))@((\[[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\])|(([a-zA-Z\-0-9]+\.)+[a-zA-Z]{2,}))$';
  RegExp regex = RegExp(pattern);
  if (value == null || value.isEmpty || !regex.hasMatch(value)) {
    return 'Enter a valid email';
  } else {
    return null;
  }
}

Future<File> pickImage() async {
  File? compressedFile;
  final Permission storage = Permission.storage;
  final Permission camera = Permission.camera;

  if (await storage.isDenied) {
    await storage.request();
  } else if (await storage.isPermanentlyDenied) {
    await storage.request();
  }
  if (await camera.isDenied) {
    await camera.request();
  } else if (await camera.isPermanentlyDenied) {
    await camera.request();
  }
  final pickedFile = await ImagePicker().pickImage(source: ImageSource.camera);
  if (pickedFile == null) return File('');

  final originalFile = File(pickedFile.path);
  final extension = path.extension('${originalFile.path}/');
}
