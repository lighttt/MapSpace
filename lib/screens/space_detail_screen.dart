import 'package:flutter/material.dart';
import 'package:mapspace/providers/map_spaces.dart';
import 'package:mapspace/screens/map_screen.dart';
import 'package:provider/provider.dart';

class SpaceDetailScreen extends StatelessWidget {
  static const routeName = "/space_detail";

  @override
  Widget build(BuildContext context) {
    final id = ModalRoute.of(context).settings.arguments as String;
    final selectedSpace =
        Provider.of<MapSpace>(context, listen: false).findById(id);
    return Scaffold(
      appBar: AppBar(
        title: Text(selectedSpace.title),
      ),
      body: Column(
        children: <Widget>[
          Container(
            height: 250,
            width: double.infinity,
            child: Image.file(
              selectedSpace.image,
              fit: BoxFit.cover,
            ),
          ),
          SizedBox(
            height: 10,
          ),
          Text(
            selectedSpace.location.address,
            textAlign: TextAlign.center,
            style:
                TextStyle(fontSize: 18, color: Theme.of(context).accentColor),
          ),
          SizedBox(
            height: 10,
          ),
          RaisedButton(
            onPressed: () {
              Navigator.push(
                  context,
                  MaterialPageRoute(
                      builder: (ctx) => MapScreen(
                            initialLocation: selectedSpace.location,
                            isSelecting: false,
                          )));
            },
            child: Text("View on Map"),
            textColor: Theme.of(context).primaryColor,
          )
        ],
      ),
    );
  }
}
