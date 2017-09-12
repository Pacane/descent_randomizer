import 'package:flutter/material.dart';

class MainMenu extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return new Scaffold(
      appBar: new AppBar(
        title: new Text('Descent 2E Randomizer'),
      ),
      body: new ListView(
        children: <Widget>[
          new MenuCard(
              'Collection',
              'Select the expansions and lieutenants you own.',
              'lib/assets/collection.png'),
          new MenuCard(
              'Open groups',
              'Pick open groups taking into account the expansions you own.',
              'lib/assets/monster_cards.png',
              route: '/randomize-monsters'),
          new MenuCard(
              '(Coming soon) Overlord decks',
              'Pick an overlord deck when playing an encounter or a campaign.',
              'lib/assets/overlord_deck.png'),
          new MenuCard(
              '(Coming soon) Plot decks',
              'Pick plot decks taking into account the lieutenant packs you own.',
              'lib/assets/plot_deck.png'),
        ],
      ),
    );
  }
}

class MenuCard extends StatelessWidget {
  final String photoUri;
  final String title;
  final String description;
  final String route;

  MenuCard(this.title, this.description, this.photoUri, {this.route});

  @override
  Widget build(BuildContext context) {
    return new GestureDetector(
      onTap: () {
        if (route != null) {
          Navigator.pushNamed(context, route);
        }
      },
      child: new Card(
        child: new Column(children: [
          new Container(
              padding: const EdgeInsets.all(8.0),
              child: new Image.asset(photoUri)),
          new ListTile(
            leading: const Icon(Icons.play_arrow),
            title: new Text(title),
            subtitle: new Text(description),
          ),
        ]),
      ),
    );
  }
}
