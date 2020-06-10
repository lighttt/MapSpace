import 'package:flutter/material.dart';
import 'package:mapspace/providers/map_spaces.dart';
import 'package:mapspace/screens/add_space_screen.dart';
import 'package:mapspace/screens/space_list_screen.dart';
import 'package:provider/provider.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (_) => MapSpace(),
      child: MaterialApp(
          title: "Map Space",
          theme: ThemeData(
            primaryColor: Colors.teal,
            accentColor: Colors.redAccent,
          ),
          home: SpaceListScreen(),
          routes: {AddSpaceScreen.routeName: (ctx) => AddSpaceScreen()}),
    );
  }
}
