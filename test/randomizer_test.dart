import 'package:descent_randomizer/randomizer.dart';
import 'package:flutter_test/flutter_test.dart';

main() {
  group('Base expansion only', () {
    test('Filter by trait only', () {
      var expected = [
        new Monster.caveSpider(),
        new Monster.zombie(),
        new Monster.ettin(),
        new Monster.goblinArcher(),
        new Monster.shadowDragon()
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

    test('Randomize more groups than possible returns all possible monsters',
        () {
      var traits = [Trait.hot];
      var queriedSize = 2;
      var expectedSize = 1;

      var actual = randomizeMonsterBy(queriedSize, traits: traits);

      expect(actual, hasLength(expectedSize));
    });

    test('Equals', () {
      var t1 = Trait.building;
      dynamic t2 = Trait.values[0];

      var m = {t1: false};

      expect(m.containsKey(t2), isTrue);
    });

  });
}
