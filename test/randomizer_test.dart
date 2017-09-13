import 'package:flutter_test/flutter_test.dart';
import 'package:descent_randomizer/descent.dart';
import 'package:descent_randomizer/randomizer.dart';

main() {
  group('Base expansion only', () {
    test('Filter by trait only', () {
      var expected = [
        Monster.caveSpider,
        Monster.zombie,
        Monster.ettin,
        Monster.goblinArcher,
        Monster.shadowDragon,
        Monster.ratSwarm,
        Monster.ironbound,
      ];

      var traits = [Trait.cave, Trait.building];

      var actual = filterMonstersBy(traits: traits);

      expect(actual, unorderedEquals(expected));
    });

    test('Randomize has correct size 1', () {
      var traits = [Trait.cave, Trait.building];
      var expectedSize = 1;

      var actual = randomizeMonsterBy(expectedSize, traits: traits);

      expect(actual, hasLength(expectedSize));
    });

    test('Randomize has correct size 2', () {
      var traits = [Trait.cave, Trait.building];
      var expectedSize = 2;

      var actual = randomizeMonsterBy(expectedSize, traits: traits);
      expect(actual, hasLength(expectedSize));
    });

    test('Filter by trait and expansion', () {
      var traits = [Trait.civilized];
      var expansions = [Expansion.shadowOfNerekhall];
      var expected = [Monster.changeling, Monster.ironbound];

      var actual = filterMonstersBy(traits: traits, expansions: expansions);

      expect(actual, unorderedEquals(expected));
    });

    test('Randomize by trait and expansion', () {
      var traits = [Trait.civilized, Trait.building];
      var expansions = [Expansion.base];
      var expected = [
        Monster.zombie,
        Monster.fleshMoulder,
        Monster.goblinArcher
      ];

      var actual =
          randomizeMonsterBy(100, traits: traits, expansions: expansions);

      expect(actual, unorderedEquals(expected));
    });
  });
}
