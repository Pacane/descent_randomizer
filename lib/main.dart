import 'package:descent_randomizer/app_state.dart';
import 'package:flutter/material.dart';
import 'widgets.dart';
import 'package:redux/redux.dart';
import 'package:flutter_redux/flutter_redux.dart';

void main() {
  runApp(new App());
}

class App extends StatelessWidget {
  static final Store<AppState> store =
      new Store(combineReducers([filtersReducer]), initialState: new AppState.initial());
  final Map<String, WidgetBuilder> routes = {
    '/': (BuildContext c) => new MainMenu(),
    '/randomize-monsters': (BuildContext c) => new MonstersPage(store),
  };

  @override
  Widget build(BuildContext context) {
    return new StoreProvider(
      store: store,
      child: new MaterialApp(
        theme: new ThemeData.dark(),
        title: 'Descent Randomizer',
        routes: routes,
      ),
    );
  }
}
