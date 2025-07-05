import 'package:flutter/material.dart';
import 'package:page_transition/page_transition.dart';

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
