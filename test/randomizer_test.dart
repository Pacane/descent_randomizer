import 'package:descent_randomizer/randomizer.dart';
import 'package:flutter_test/flutter_test.dart';

main() {
  group('Base expansion only', () {
    test('Filter by  trait only', () {
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
  });
}
