import 'dart:math';

List<Monster> allMonsters = [
  new Monster.fleshMoulder(),
  new Monster.zombie(),
  new Monster.caveSpider(),
  new Monster.barghest(),
  new Monster.elemental(),
  new Monster.ettin(),
  new Monster.goblinArcher(),
  new Monster.merriod(),
  new Monster.shadowDragon(),
];

List<Monster> filterMonstersBy({List<Trait> traits}) {
  return allMonsters
      .where((Monster m) => m.traits.any((Trait t) => traits.contains(t)))
      .toList();
}

List<Monster> randomizeMonsterBy(int count, {List<Trait> traits}) {
  var filteredMonsters = filterMonstersBy(traits: traits);
  var rng = new Random();
  var result = <Monster>[];
  for (int i = 0; i < count; ++i) {
    if (filteredMonsters.isEmpty) {
      return result;
    }

    int index = 0;

    if (filteredMonsters.length > 1) {
      index = rng.nextInt(filteredMonsters.length - 1);
    }

    result.add(filteredMonsters[index]);
    filteredMonsters.removeAt(index);
  }

  return result;
}

class Monster {
  final String name;
  final Expansion expansion;
  final Set<Trait> traits;
  final Attack attack;

  Monster._(this.name, this.attack, this.traits, this.expansion);

  factory Monster.fleshMoulder() => new Monster._(
      "Flesh Moulder",
      Attack.ranged,
      new Set.from([Trait.cursed, Trait.civilized]),
      Expansion.base);

  factory Monster.goblinArcher() => new Monster._(
      "Goblin Archer",
      Attack.ranged,
      new Set.from([Trait.building, Trait.cave]),
      Expansion.base);

  factory Monster.ettin() => new Monster._("Ettin", Attack.melee,
      new Set.from([Trait.mountain, Trait.cave]), Expansion.base);

  factory Monster.elemental() => new Monster._("Elemental", Attack.ranged,
      new Set.from([Trait.cold, Trait.hot]), Expansion.base);
  factory Monster.barghest() => new Monster._("Barghest", Attack.melee,
      new Set.from([Trait.wilderness, Trait.dark]), Expansion.base);

  factory Monster.caveSpider() => new Monster._("Cave Spider", Attack.melee,
      new Set.from([Trait.wilderness, Trait.cave]), Expansion.base);

  factory Monster.merriod() => new Monster._("Merriod", Attack.melee,
      new Set.from([Trait.wilderness, Trait.water]), Expansion.base);

  factory Monster.shadowDragon() => new Monster._("Shadow Dragon", Attack.melee,
      new Set.from([Trait.dark, Trait.cave]), Expansion.base);

  factory Monster.zombie() => new Monster._("Zombie", Attack.melee,
      new Set.from([Trait.cursed, Trait.building]), Expansion.base);

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is Monster &&
          runtimeType == other.runtimeType &&
          name == other.name &&
          expansion == other.expansion &&
          traits.containsAll(other.traits) &&
          attack == other.attack;

  @override
  String toString() => '$name';

  @override
  int get hashCode =>
      name.hashCode ^ expansion.hashCode ^ traits.hashCode ^ attack.hashCode;
}

enum Attack { melee, ranged }

enum Expansion { base, shadowOfNerekhall, chainsThatRust }

class Trait {
  final String name;

  const Trait._(this.name);

  static const building = const Trait._('Building');
  static const cave = const Trait._('Cave');
  static const civilized = const Trait._('Civilized');
  static const cold = const Trait._('Cold');
  static const cursed = const Trait._('Cursed');
  static const dark = const Trait._('Dark');
  static const hot = const Trait._('Hot');
  static const mountain = const Trait._('Mountain');
  static const water = const Trait._('Water');
  static const wilderness = const Trait._('Wilderness');

  static const List<Trait> values = const [
    building,
    cave,
    civilized,
    cold,
    cursed,
    dark,
    hot,
    mountain,
    water,
    wilderness
  ];
}

enum Size {
// Note: Medium, Huge, and Massive monsters are Large monsters for the purposes of movement and quest rules.
  small, // monsters occupy one space (e.g., Goblin Archers and Zombies)
  medium, // monsters occupy two spaces (e.g., Barghests)
  huge, // monsters occupy four spaces (e.g., Ettins and Merriods)
  massive, // monsters occupy six spaces (e.g., Shadow Dragons)
}
