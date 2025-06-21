import 'package:flutter/material.dart';
import 'package:page_transition/page_transition.dart';

void navigateTo(context, widget) => Navigator.push(
  context,
  PageTransition(
    alignment: Alignment.center,
    type: PageTransitionType.rightToLeftJoined,
    childCurrent: widget,
    duration: const Duration(milliseconds: 500),
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
