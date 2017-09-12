import 'package:flutter/material.dart';
import 'package:redux/redux.dart';
import 'package:flutter_redux/flutter_redux.dart';
import '../app_state.dart';
import '../utils.dart';
import '../randomizer.dart';

class ExpansionSelector extends StatelessWidget {
  final Store<AppState> store;

  ExpansionSelector(this.store);

  @override
  Widget build(BuildContext context) {
    return new StoreProvider(
      store: store,
      child: new ListView(
        children: <Widget>[]
          ..add(
            new DrawerHeader(
              child: const Text(
                'Select your expansions',
                style: const TextStyle(fontSize: 32.0),
              ),
            ),
          )
          ..add(
            new StoreConnector<AppState, Iterable<Tuple<Expansion, bool>>>(
                builder: (context, expansions) => new Column(
                  children: expansions
                      .map((Tuple<Expansion, bool> t) =>
                  new CheckboxListTile(
                    value: t.s,
                    title: new Text(t.f.name),
                    onChanged: (bool v) => store.dispatch(
                        new UpdateExpansionFilterAction(t.f, v)),
                  ))
                      .toList(),
                ),
                converter: (store) {
                  var expansions = store.state.expansionsFilters;
                  return expansions.keys
                      .map((Expansion e) => new Tuple(e, expansions[e]));
                }),
          ),
      ),
    );
  }
}
