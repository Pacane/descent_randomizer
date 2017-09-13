import 'dart:math';
import 'descent.dart';

List<Monster> filterMonstersBy(
    {List<Trait> traits = const [], List<Expansion> expansions = const []}) {
  Iterable<Monster> filtered = allMonsters;

  if (expansions.isNotEmpty) {
    filtered =
        allMonsters.where((Monster m) => expansions.contains(m.expansion));
  }

  if (traits.isNotEmpty) {
    filtered = filtered
        .where((Monster m) => m.traits.any((Trait t) => traits.contains(t)));
  }

  return filtered.toList();
}

List<Monster> randomizeMonsterBy(int count,
    {List<Trait> traits = const [], List<Expansion> expansions = const []}) {
  var filteredMonsters =
      filterMonstersBy(traits: traits, expansions: expansions);
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
