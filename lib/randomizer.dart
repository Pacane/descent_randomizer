import 'dart:math';

List<Monster> allMonsters = [
  new Monster("Flesh Moulder", Attack.ranged,
      new Set.from([Trait.cursed, Trait.civilized]), Expansion.base),
  new Monster("Goblin Archer", Attack.ranged,
      new Set.from([Trait.building, Trait.cave]), Expansion.base),
  new Monster("Ettin", Attack.melee, new Set.from([Trait.mountain, Trait.cave]),
      Expansion.base),
  new Monster("Elemental", Attack.ranged, new Set.from([Trait.cold, Trait.hot]),
      Expansion.base),
  new Monster("Barghest", Attack.melee,
      new Set.from([Trait.wilderness, Trait.dark]), Expansion.base),
  new Monster("Cave Spider", Attack.melee,
      new Set.from([Trait.wilderness, Trait.cave]), Expansion.base),
  new Monster("Merriod", Attack.melee,
      new Set.from([Trait.wilderness, Trait.water]), Expansion.base),
  new Monster("Shadow Dragon", Attack.melee,
      new Set.from([Trait.dark, Trait.cave]), Expansion.base),
  new Monster("Zombie", Attack.melee,
      new Set.from([Trait.cursed, Trait.building]), Expansion.base)
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
    var nextIndex = rng.nextInt(filteredMonsters.length - 1);
    if (nextIndex < 0) {
      return result;
    }

    result.add(filteredMonsters[nextIndex]);
    filteredMonsters.removeAt(nextIndex);
  }

  return result;
}

class Monster {
  final String name;
  final Expansion expansion;
  final Set<Trait> traits;
  final Attack attack;

  Monster(this.name, this.attack, this.traits, this.expansion);

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
  int get hashCode =>
      name.hashCode ^ expansion.hashCode ^ traits.hashCode ^ attack.hashCode;
}

enum Attack { melee, ranged }

enum Expansion { base, shadowOfNerekhall, chainsThatRust }

enum Trait {
  building,
  cave,
  civilized,
  cold,
  cursed,
  dark,
  hot,
  mountain,
  water,
  wilderness,
}

enum Size {
// Note: Medium, Huge, and Massive monsters are Large monsters for the purposes of movement and quest rules.
  small, // monsters occupy one space (e.g., Goblin Archers and Zombies)
  medium, // monsters occupy two spaces (e.g., Barghests)
  huge, // monsters occupy four spaces (e.g., Ettins and Merriods)
  massive, // monsters occupy six spaces (e.g., Shadow Dragons)
}
