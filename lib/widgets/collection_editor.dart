import 'package:flutter/material.dart';
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

  CollectionEditorState(this.store);

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
          new LieutenantsGrid(store),
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

class LieutenantsGrid extends StatelessWidget {
  final Store<AppState> store;

  LieutenantsGrid(this.store);

  @override
  Widget build(BuildContext context) {
    var orientation = MediaQuery.of(context).orientation;
    return new GridView.count(
      primary: false,
      padding: const EdgeInsets.all(8.0),
      crossAxisSpacing: 4.0,
      mainAxisSpacing: 4.0,
      crossAxisCount: orientation == Orientation.portrait ? 2 : 3,
      children: LieutenantPack.values
          .map((LieutenantPack l) => new LieutenantTile(store, l))
          .toList(),
    );
  }
}

class LieutenantTile extends StatelessWidget {
  final Store<AppState> store;
  final LieutenantPack lieutenant;

  LieutenantTile(this.store, this.lieutenant);

  @override
  Widget build(BuildContext context) {
    var onTap =
        () => store.dispatch(new UpdateLieutenantsFiltersAction(lieutenant));
    return new StoreProvider(
        store: store,
        child: new StoreConnector<AppState, bool>(
          builder: (context, bool lieutenantEnabled) => new GestureDetector(
                onTap: onTap,
                child: new GridTile(
                  footer: new GridTileBar(
                    backgroundColor: Colors.black54,
                    subtitle: new _GridTitleText(
                      lieutenant.name,
                      lieutenantEnabled,
                      onTap,
                    ),
                  ),
                  child: new Container(
                    padding: const EdgeInsets.all(8.0),
                    child: new Image.asset(lieutenant.assetPath),
                    decoration: new BoxDecoration(
                      color: Colors.black54,
                    ),
                  ),
                ),
              ),
          converter: (store) => store.state.lieutenantsFilters[lieutenant],
        ));
  }
}

class ExpansionTile extends StatelessWidget {
  final Store<AppState> store;
  final Expansion expansion;

  ExpansionTile(this.store, this.expansion);

  @override
  Widget build(BuildContext context) {
    var onTap =
        () => store.dispatch(new UpdateExpansionFilterAction(expansion));
    return new StoreProvider(
        store: store,
        child: new StoreConnector<AppState, bool>(
          builder: (context, bool expansionEnabled) => new GestureDetector(
                onTap: onTap,
                child: new GridTile(
                  footer: new GridTileBar(
                    backgroundColor: Colors.black54,
                    subtitle: new _GridTitleText(
                      expansion.name,
                      expansionEnabled,
                      onTap,
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
  final void Function() onChanged;

  _GridTitleText(this.text, this.value, this.onChanged);

  final String text;

  @override
  Widget build(BuildContext context) {
    return new FittedBox(
      fit: BoxFit.scaleDown,
      alignment: FractionalOffset.centerLeft,
      child: new Row(children: <Widget>[
        new Checkbox(
            value: value,
            onChanged: (_) => onChanged()),
        new Text(text),
      ]),
    );
  }
}
