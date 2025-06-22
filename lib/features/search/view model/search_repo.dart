import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';

class SearchRepo extends ChangeNotifier {
  final ScrollController _scrollController = ScrollController();
  ScrollController get scrollController => _scrollController;

  bool _isShowBottom = true;
  bool get isShowBottom => _isShowBottom;

  bool _isListenerAdded = false;

  void hideScrollBar() {
    if (_isListenerAdded) return;

    _scrollController.addListener(() {
      if (_scrollController.position.userScrollDirection ==
          ScrollDirection.reverse) {
        if (_isShowBottom) {
          _isShowBottom = false;
          notifyListeners();
        }
      } else if (_scrollController.position.userScrollDirection ==
          ScrollDirection.forward) {
        if (!_isShowBottom) {
          _isShowBottom = true;
          notifyListeners();
        }
      }
    });

    _isListenerAdded = true;
  }
}
