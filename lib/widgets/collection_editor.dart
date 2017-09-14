import 'package:flutter/material.dart';
import 'package:meta/meta.dart';
import 'package:redux/redux.dart';
import 'package:flutter_redux/flutter_redux.dart';
import '../app_state.dart';
import '../descent.dart';

class CollectionEditor extends StatefulWidget {
  final Store<AppState> store;

  CollectionEditor(this.store);

  @override
  State<StatefulWidget> createState() => new CollectionEditorState(store);
}

class CollectionEditorState extends State<CollectionEditor>
    with SingleTickerProviderStateMixin {
  final Store<AppState> store;

  TabController _tabController;

  @override
  void initState() {
    super.initState();
    _tabController = new TabController(vsync: this, length: 2);
  }

  @override
  void dispose() {
    _tabController.dispose();
    super.dispose();
  }

  CollectionEditorState(this.store);

  @override
  Widget build(BuildContext context) {
    var tabs = [
      new Tab(text: 'EXPANSIONS'),
      new Tab(text: 'LIEUTENANTS'),
    ];

    return new Scaffold(
      appBar: new AppBar(
        title: const Text('Edit collection'),
        bottom: new TabBar(
          controller: _tabController,
          tabs: tabs,
        ),
      ),
      body: new TabBarView(
        children: [
          new ExpansionsGrid(store),
        ],
        controller: _tabController,
      ),
    );
  }
}

class ExpansionsGrid extends StatelessWidget {
  final Store<AppState> store;

  ExpansionsGrid(this.store);

  @override
  Widget build(BuildContext context) {
    var orientation = MediaQuery.of(context).orientation;
    return new GridView.count(
      primary: false,
      padding: const EdgeInsets.all(8.0),
      crossAxisSpacing: 4.0,
      mainAxisSpacing: 4.0,
      crossAxisCount: orientation == Orientation.portrait ? 2 : 3,
      children: Expansion.values
          .map((Expansion e) => new ExpansionTile(store, e))
          .toList(),
    );
  }
}

class ExpansionTile extends StatelessWidget {
  final Store<AppState> store;
  final Expansion expansion;

  ExpansionTile(this.store, this.expansion);

  @override
  Widget build(BuildContext context) {
    return new StoreProvider(
        store: store,
        child: new StoreConnector<AppState, bool>(
          builder: (context, bool expansionEnabled) => new GestureDetector(
                onTap: () => store.dispatch(new UpdateExpansionFilterAction(
                    expansion, !store.state.expansionsFilters[expansion])),
                child: new GridTile(
                  footer: new GridTileBar(
                    backgroundColor: Colors.black54,
                    subtitle: new _GridTitleText(
                      expansion.name,
                      expansionEnabled,
                    ),
                  ),
                  child: new Container(
                    padding: const EdgeInsets.all(8.0),
                    child: new Image.asset(expansion.assetPath),
                    decoration: new BoxDecoration(
                      color: Colors.black54,
                    ),
                  ),
                ),
              ),
          converter: (store) => store.state.expansionsFilters[expansion],
        ));
  }
}

class _GridTitleText extends StatelessWidget {
  final bool value;

  _GridTitleText(this.text, this.value);

  final String text;

  @override
  Widget build(BuildContext context) {
    return new FittedBox(
      fit: BoxFit.scaleDown,
      alignment: FractionalOffset.centerLeft,
      child: new Row(children: <Widget>[
        new Text(text),
        new Checkbox(value: value, onChanged: (_) {})
      ]),
    );
  }
}
