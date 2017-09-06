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
      title: 'Flutter Demo',
      theme: new ThemeData(
        primarySwatch: Colors.green,
      ),
      home: new MyHomePage(title: 'Descent open group randomizer'),
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
  Map<Trait, bool> traitFilters = {};

  @override
  void initState() {
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
        child: new Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: traits
                .map((Trait t) => new TraitCheckbox(
                      t,
                      traitFilters,
                      onChanged: (bool v) => setState(() {
                            traitFilters[t] = v;
                          }),
                    ))
                .toList()),
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
