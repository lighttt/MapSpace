import 'dart:io';

import 'package:flutter/material.dart';
import 'package:mapspace/model/space.dart';

class MapSpace with ChangeNotifier {
  List<Space> _items = [];

  List<Space> get items {
    return [..._items];
  }

  // to add new space
  void addSpace(String pickedTitle, File pickedImage) {
    final newSpace = Space(
      id: DateTime.now().toString(),
      image: pickedImage,
      title: pickedTitle,
      location: null,
    );
    _items.add(newSpace);
    notifyListeners();
  }
}
