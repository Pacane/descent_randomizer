import 'package:flutter/material.dart';
import 'widgets.dart';

void main() {
  runApp(new MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return new MaterialApp(
      theme: new ThemeData.dark(),
      title: 'Descent Randomizer',
      routes: routes,
    );
  }
}

Map<String, WidgetBuilder> routes = {
  '/': (BuildContext c) => new MainMenu(),
  '/randomize-monsters': (BuildContext c) => new MonstersPage(),
//    '/plot-decks': (BuildContext c) => new PlotDecks(),
//    '/overlord-decks': (BuildContext c) => new OverlordDecks(),
};
