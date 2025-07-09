import 'dart:io';
import 'package:blood_donation/features/widgets/custom_snack_bar.dart';
import 'package:flutter_image_compress/flutter_image_compress.dart';
import 'package:path/path.dart' as path;
import 'package:flutter/material.dart';
import 'package:page_transition/page_transition.dart';
import 'package:path_provider/path_provider.dart';
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

void justNavigate({required BuildContext context, required Widget route}) {
  Navigator.push(context, MaterialPageRoute(builder: (context) => route));
}

void dialog({
  required BuildContext context,
  required String title,
  required Widget content,
}) {
  showDialog(
    context: context,
    builder: (context) => AlertDialog(
      backgroundColor: Colors.white,
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

Future<File> imagePickerFromSource({
  required BuildContext context,
  required ImageSource imageSource,
}) async {
  File? compressedImage;
  try {
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
    final pickedFile = await ImagePicker().pickImage(source: imageSource);
    if (pickedFile == null) return File('');

    final originalFile = File(pickedFile.path);
    final extension = path.extension(originalFile.path).toLowerCase();

    final tempDir = await getTemporaryDirectory();

    final fileName =
        "${DateTime.now().millisecondsSinceEpoch}_${path.basenameWithoutExtension(originalFile.path)}$extension";

    final targetPath = path.join(tempDir.path, fileName);

    CompressFormat format = CompressFormat.png;

    if (extension == '.jpg' || extension == '.jpeg') {
      format = CompressFormat.jpeg;
    }
    final compressed = await FlutterImageCompress.compressAndGetFile(
      originalFile.path,
      targetPath,
      quality: 80,
      format: format,
    );

    if (compressed != null) {
      compressedImage = File(compressed.path);
    } else {
      compressedImage = originalFile;
    }

    return compressedImage;
  } catch (e) {
    if (context.mounted) {
      failedSnackBar(message: e.toString(), context: context);
    }
    return File('');
  }
}
