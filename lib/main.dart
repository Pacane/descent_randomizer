import 'package:flutter/material.dart';
import 'package:descent_randomizer/randomizer.dart';

void main() {
  runApp(new MyApp());
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return new MaterialApp(
      title: 'Descent Open Group Randomizer',
      theme: new ThemeData(
        primarySwatch: Colors.green,
      ),
      home: new MyHomePage(title: 'Descent Open Group Randomizer'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  MyHomePage({Key key, this.title}) : super(key: key);

  final String title;

  @override
  _MyHomePageState createState() => new _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  final List<Trait> traits = Trait.values;
  final Map<Trait, bool> traitFilters = {};

  int numberOfGroups = 2;
  List<Monster> foundMonsters = [];

  @override
  void initState() {
    super.initState();
    traits.forEach((Trait t) {
      traitFilters[t] = false;
    });
  }

  @override
  Widget build(BuildContext context) {
    return new Scaffold(
      appBar: new AppBar(
        title: new Text(widget.title),
      ),
      body: new Center(
        child: new ListView(
          padding: new EdgeInsets.all(8.0),
          children: <Widget>[]
            ..add(new ListTile(
                leading: const CircleAvatar(child: const Text('#')),
                trailing: new Text(
                  numberOfGroups.toString(),
                  style: const TextStyle(fontSize: 32.0),
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
            ..add(new RaisedButton(
                onPressed: () => setState(() {
                      var activeTraitFilters = traits
                          .where((Trait t) => traitFilters[t] == true)
                          .toList();
                      foundMonsters = randomizeMonsterBy(numberOfGroups,
                          traits: activeTraitFilters);
                      print('Found monsters = $foundMonsters');
                    }),
                child: const Text('Randomize')))
            ..addAll(
                foundMonsters.map((Monster m) => new MonsterWidget(m.name))),
        ),
      ),
    );
  }
}

class TraitCheckbox extends CheckboxListTile {
  final Trait trait;

  TraitCheckbox(Trait t, Map<Trait, bool> traitFilters,
      {ValueChanged<bool> onChanged})
      : trait = t,
        super(
            key: new ObjectKey(t),
            value: traitFilters[t] == true,
            onChanged: onChanged,
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
        ));
}
