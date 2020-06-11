import 'dart:io';

import 'package:flutter/material.dart';
import 'package:mapspace/helper/db_helper.dart';
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
    //inserting to db
    DBHelper.insert('user_spaces', {
      'id': newSpace.id,
      'title': newSpace.title,
      'image': newSpace.image.path,
    });
  }

  //fetching data
  Future<void> fetchAndSetSpaces() async {
    final dataList = await DBHelper.getData('user_spaces');
    _items = dataList
        .map((item) => Space(
            id: item['id'],
            title: item['title'],
            image: File(item['image']),
            location: null))
        .toList();
    notifyListeners();
  }
}
