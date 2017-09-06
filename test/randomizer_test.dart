import 'package:descent_randomizer/randomizer.dart';
import 'package:flutter_test/flutter_test.dart';

main() {
  group('Base expansion only', () {
    test('Filter by  trait only', () {
      var actual = filterMonstersBy(traits: [Trait.cave, Trait.building]);


    });
  });
}