import 'package:flutter/material.dart';
import 'package:page_transition/page_transition.dart';

void navigateTo(context, widget) => Navigator.push(
  context,
  PageTransition(
    type: PageTransitionType.fade,
    duration: const Duration(milliseconds: 600),
    child: widget,
  ),
);

void navigateAndFinish(context, widget) => Navigator.pushAndRemoveUntil(
  context,
  PageTransition(
    type: PageTransitionType.fade,
    duration: const Duration(milliseconds: 600),
    child: widget,
  ),
  (route) => false,
);
