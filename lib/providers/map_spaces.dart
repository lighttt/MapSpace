import 'dart:io';

import 'package:flutter/material.dart';
import 'package:mapspace/helper/db_helper.dart';
import 'package:mapspace/helper/location_helper.dart';
import 'package:mapspace/model/space.dart';

class MapSpace with ChangeNotifier {
  List<Space> _items = [];

  List<Space> get items {
    return [..._items];
  }

  // to add new space
  Future<void> addSpace(String pickedTitle, File pickedImage,
      SpaceLocation pickedLocation) async {
    final address = await LocationHelper.getSpaceAddress(
        pickedLocation.latitude, pickedLocation.longitude);
    final updatedLocation = SpaceLocation(
        latitude: pickedLocation.latitude,
        longitude: pickedLocation.longitude,
        address: address);
    print(address);
    final newSpace = Space(
      id: DateTime.now().toString(),
      image: pickedImage,
      title: pickedTitle,
      location: updatedLocation,
    );
    _items.add(newSpace);
    notifyListeners();

    //inserting to db
    DBHelper.insert('user_spaces', {
      'id': newSpace.id,
      'title': newSpace.title,
      'image': newSpace.image.path,
      'loc_lat': newSpace.location.latitude,
      'loc_lng': newSpace.location.longitude,
      'address': newSpace.location.address,
    });
  }

  //fetching data
  Future<void> fetchAndSetSpaces() async {
    final dataList = await DBHelper.getData('user_spaces');
    _items = dataList
        .map(
          (item) => Space(
            id: item['id'],
            title: item['title'],
            image: File(item['image']),
            location: SpaceLocation(
              latitude: item['loc_lat'],
              longitude: item['loc_lng'],
              address: item['address'],
            ),
          ),
        )
        .toList();
    notifyListeners();
  }

  //find by id
  Space findById(String id) {
    return _items.firstWhere((space) => space.id == id);
  }
}
