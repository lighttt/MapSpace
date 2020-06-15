import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:mapspace/model/space.dart';

class MapScreen extends StatefulWidget {
  final SpaceLocation initialLocation;
  final bool isSelecting;

  MapScreen(
      {this.initialLocation =
          const SpaceLocation(latitude: 27.7172, longitude: 85.3240),
      this.isSelecting = false});

  @override
  _MapScreenState createState() => _MapScreenState();
}

class _MapScreenState extends State<MapScreen> {
  LatLng _pickedLocation;

  void _selectSpace(LatLng position) {
    setState(() {
      _pickedLocation = position;
      print(_pickedLocation.latitude);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Your Space"),
      ),
      body: GoogleMap(
        initialCameraPosition: CameraPosition(
            target: LatLng(widget.initialLocation.latitude,
                widget.initialLocation.longitude),
            zoom: 16),
        onTap: widget.isSelecting ? _selectSpace : null,
        markers: _pickedLocation == null
            ? null
            : {
                Marker(
                  markerId: MarkerId("m1"),
                  position: _pickedLocation,
                )
              },
      ),
    );
  }
}
