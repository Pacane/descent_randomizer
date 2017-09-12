import 'package:flutter/material.dart';
import 'package:flutter_redux/flutter_redux.dart';
import 'package:redux/redux.dart';
import '../randomizer.dart';
import '../app_state.dart';
import '../utils.dart';

class MonstersPage extends StatelessWidget {
  MonstersPage(this.store, {Key key}) : super(key: key);

  final Store<AppState> store;

  @override
  Widget build(BuildContext context) {
    return new StoreProvider(
        store: store,
        child: new Scaffold(
          appBar: new AppBar(
            title: new Text('Random open groups'),
          ),
          body: new Center(
            child: new ListView(
                padding: new EdgeInsets.all(8.0),
                children: <Widget>[]
                  ..add(
                    new ListTile(
                      leading: const CircleAvatar(
                        child: const Text('#'),
                      ),
                      trailing: new StoreConnector<AppState, int>(
                          converter: (store) => store.state.numberOfGroups,
                          builder: (context, nbOfMonsters) => new Text(
                                nbOfMonsters.toString(),
                                style: const TextStyle(fontSize: 20.0),
                              )),
                      title: new StoreConnector<AppState, int>(
                        converter: (store) => store.state.numberOfGroups,
                        builder: (context, numberOfGroups) => new Slider(
                              value: numberOfGroups.toDouble(),
                              max: 5.0,
                              min: 1.0,
                              onChanged: (double n) => store.dispatch(
                                    new ChangeNumberOfGroupsAction(n.round()),
                                  ),
                            ),
                      ),
                    ),
                  )
                  ..add(
                    new StoreConnector<AppState, List<Tuple<Trait, bool>>>(
                      converter: (store) => store.state.traitsFilters.keys
                          .map((Trait t) =>
                              new Tuple(t, store.state.traitsFilters[t]))
                          .toList(),
                      builder: (context, traits) => new Column(
                            children: traits
                                .map((Tuple<Trait, bool> tu) =>
                                    new TraitCheckbox(
                                      tu.f,
                                      tu.s,
                                      onChanged: (bool v) => store.dispatch(
                                          new UpdateTraitFilterAction(tu.f, v)),
                                    ))
                                .toList(),
                          ),
                    ),
                  )
                  ..add(
                    new RaisedButton(
                      onPressed: () {
                        store.dispatch(new DrawMonsterGroups());
                        showDialog(
                            context: context,
                            child: new SimpleDialog(
                                title: const Text('Drawn monster groups'),
                                children: [
                                  new StoreConnector<AppState, List<Monster>>(
                                      builder: (context, monsters) =>
                                          new Column(
                                            children: monsters
                                                .map((Monster m) =>
                                                    new MonsterWidget(m.name))
                                                .toList(),
                                          ),
                                      converter: (store) =>
                                          store.state.foundMonsters),
                                  new FlatButton(
                                      onPressed: () => Navigator.pop(context),
                                      child: const Text('OK')),
                                ]));
                      },
                      child: const Text('Randomize'),
                    ),
                  )),
          ),
        ));
  }
}

class TraitCheckbox extends ListTile {
  final Trait trait;

  TraitCheckbox(Trait t, bool value, {ValueChanged<bool> onChanged})
      : trait = t,
        super(
          key: new ObjectKey(t),
          trailing: new Checkbox(value: value, onChanged: onChanged),
          leading: new Image.asset(t.assetPath),
          title: new Text(t.name),
        );
}

class MonsterWidget extends ListTile {
  final String name;

  MonsterWidget(String name)
      : name = name,
        super(
          title: new Text(
            name,
            style: new TextStyle(color: Colors.red),
          ),
        );
}


