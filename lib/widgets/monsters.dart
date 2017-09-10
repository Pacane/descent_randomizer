import 'package:flutter/material.dart';
import '../randomizer.dart';

class MonstersPage extends StatefulWidget {
  MonstersPage({Key key}) : super(key: key);

  @override
  MonstersPageState createState() => new MonstersPageState();
}

class MonstersPageState extends State<MonstersPage> {
  final List<Trait> traits = Trait.values;
  final List<Expansion> expansions = Expansion.values;
  final Map<Trait, bool> traitFilters = {};
  final Map<Expansion, bool> expansionFilters = {};

  static const int defaultNumberOfGroups = 2;

  int numberOfGroups = defaultNumberOfGroups;
  List<Monster> foundMonsters = [];

  @override
  void initState() {
    super.initState();
    traits.forEach((Trait t) {
      traitFilters[t] = false;
    });

    expansions.forEach((Expansion e) {
      expansionFilters[e] = false;
    });

    expansionFilters[Expansion.base] = true;
  }

  @override
  Widget build(BuildContext context) {
    return new Scaffold(
      appBar: new AppBar(
        title: new Text('Random open groups'),
      ),
      drawer: new Drawer(
        child: new ListView(
          children: <Widget>[]
            ..add(new DrawerHeader(
                child: const Text(
              'Select your expansions',
              style: const TextStyle(fontSize: 32.0),
            )))
            ..addAll(expansions.map(
              (Expansion e) => new CheckboxListTile(
                    value: expansionFilters[e] == true,
                    title: new Text(e.name),
                    onChanged: (bool v) => setState(() {
                          expansionFilters[e] = v;
                        }),
                  ),
            )),
        ),
      ),
      body: new Center(
        child: new ListView(
          padding: new EdgeInsets.all(8.0),
          children: <Widget>[]
            ..add(new ListTile(
                leading: const CircleAvatar(
                  child: const Text('#'),
                ),
                trailing: new Text(
                  numberOfGroups.toString(),
                  style: const TextStyle(fontSize: 20.0),
                ),
                title: new Slider(
                  value: numberOfGroups.toDouble(),
                  max: 5.0,
                  min: 1.0,
                  onChanged: (double n) =>
                      setState(() => numberOfGroups = n.round()),
                )))
            ..addAll(traits.map<Widget>((Trait t) => new TraitCheckbox(
                  t,
                  traitFilters,
                  onChanged: (bool v) => setState(() {
                        traitFilters[t] = v;
                      }),
                )))
            ..add(
              new RaisedButton(
                onPressed: () => setState(() {
                      var activeTraitFilters = traits
                          .where((Trait t) => traitFilters[t] == true)
                          .toList();
                      foundMonsters = randomizeMonsterBy(numberOfGroups,
                          traits: activeTraitFilters);
                      print('Found monsters = $foundMonsters');
                    }),
                child: const Text('Randomize'),
              ),
            )
            ..addAll(
                foundMonsters.map((Monster m) => new MonsterWidget(m.name))),
        ),
      ),
    );
  }
}

class TraitCheckbox extends ListTile {
  final Trait trait;

  TraitCheckbox(Trait t, Map<Trait, bool> traitFilters,
      {ValueChanged<bool> onChanged})
      : trait = t,
        super(
            key: new ObjectKey(t),
            trailing: new Checkbox(
                value: traitFilters[t] == true, onChanged: onChanged),
            leading: new Image.asset(t.assetPath),
            title: new Text(t.name));
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
