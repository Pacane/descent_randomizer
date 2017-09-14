class Monster {
  final String name;
  final Expansion expansion;
  final Set<Trait> traits;
  final Attack attack;
  final Size size;

  const Monster._(
      this.name, this.attack, this.traits, this.expansion, this.size);

  static Monster fleshMoulder = new Monster._(
    "Flesh Moulder",
    Attack.ranged,
    new Set.from([Trait.cursed, Trait.civilized]),
    Expansion.base,
    Size.small,
  );

  static Monster goblinArcher = new Monster._("Goblin Archer", Attack.ranged,
      new Set.from([Trait.building, Trait.cave]), Expansion.base, Size.small);

  static Monster ettin = new Monster._(
    "Ettin",
    Attack.melee,
    new Set.from([Trait.mountain, Trait.cave]),
    Expansion.base,
    Size.huge,
  );

  static Monster elemental = new Monster._(
    "Elemental",
    Attack.ranged,
    new Set.from([Trait.cold, Trait.hot]),
    Expansion.base,
    Size.huge,
  );

  static Monster barghest = new Monster._(
    "Barghest",
    Attack.melee,
    new Set.from([Trait.wilderness, Trait.dark]),
    Expansion.base,
    Size.medium,
  );

  static Monster caveSpider = new Monster._(
    "Cave Spider",
    Attack.melee,
    new Set.from([Trait.wilderness, Trait.cave]),
    Expansion.base,
    Size.small,
  );

  static Monster merriod = new Monster._(
    "Merriod",
    Attack.melee,
    new Set.from([Trait.wilderness, Trait.water]),
    Expansion.base,
    Size.huge,
  );

  static Monster shadowDragon = new Monster._(
    "Shadow Dragon",
    Attack.melee,
    new Set.from([Trait.dark, Trait.cave]),
    Expansion.base,
    Size.massive,
  );

  static Monster zombie = new Monster._(
    "Zombie",
    Attack.melee,
    new Set.from([Trait.cursed, Trait.building]),
    Expansion.base,
    Size.small,
  );

  static Monster changeling = new Monster._(
    "Changeling",
    Attack.melee,
    new Set.from([Trait.cursed, Trait.civilized]),
    Expansion.shadowOfNerekhall,
    Size.small,
  );

  static Monster ratSwarm = new Monster._(
    "Rat swarm",
    Attack.melee,
    new Set.from([Trait.building, Trait.dark]),
    Expansion.shadowOfNerekhall,
    Size.medium,
  );

  static Monster ironbound = new Monster._(
    "Ironbound",
    Attack.melee,
    new Set.from([Trait.building, Trait.civilized]),
    Expansion.shadowOfNerekhall,
    Size.small,
  );

  static Monster infernaelHulk = new Monster._(
    "Infernael Hulk",
    Attack.melee,
    new Set.from([Trait.cursed, Trait.hot]),
    Expansion.shadowOfNerekhall,
    Size.huge,
  );

  static List<Monster> values = [
    Monster.fleshMoulder,
    Monster.zombie,
    Monster.caveSpider,
    Monster.barghest,
    Monster.elemental,
    Monster.ettin,
    Monster.goblinArcher,
    Monster.merriod,
    Monster.shadowDragon,
    Monster.changeling,
    Monster.ironbound,
    Monster.infernaelHulk,
    Monster.ratSwarm,
  ];

  @override
  bool operator ==(covariant Monster other) =>
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

class Expansion {
  final String name;
  final String assetName;

  const Expansion._(this.name, this.assetName);

  static Expansion base =
      const Expansion._('Descent 2E Base Set', 'base_set.png');
  static Expansion chainsThatRust =
      const Expansion._('The Chains That Rust', 'chains_that_rust.png');
  static Expansion shadowOfNerekhall =
      const Expansion._('Shadow of Nerekhall', 'shadow_of_nerekhall.png');

  static List<Expansion> values = [
    base,
    chainsThatRust,
    shadowOfNerekhall,
  ];

  String get assetPath => 'lib/assets/$assetName';

  @override
  bool operator ==(covariant Expansion other) => name == other.name;

  @override
  int get hashCode => name.hashCode;
}

class Trait {
  final String name;

  const Trait._(this.name);

  static const Trait building = const Trait._('Building');
  static const Trait cave = const Trait._('Cave');
  static const Trait civilized = const Trait._('Civilized');
  static const Trait cold = const Trait._('Cold');
  static const Trait cursed = const Trait._('Cursed');
  static const Trait dark = const Trait._('Dark');
  static const Trait hot = const Trait._('Hot');
  static const Trait mountain = const Trait._('Mountain');
  static const Trait water = const Trait._('Water');
  static const Trait wilderness = const Trait._('Wilderness');

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
    wilderness,
  ];

  String get assetPath => 'lib/assets/${name.toLowerCase()}.png';

  @override
  bool operator ==(covariant Trait other) => name == other.name;

  @override
  int get hashCode => name.hashCode;
}

enum Size {
// Note: Medium, Huge, and Massive monsters are Large monsters for the purposes of movement and quest rules.
  small, // monsters occupy one space (e.g., Goblin Archers and Zombies)
  medium, // monsters occupy two spaces (e.g., Barghests)
  huge, // monsters occupy four spaces (e.g., Ettins and Merriods)
  massive, // monsters occupy six spaces (e.g., Shadow Dragons)
}

class LieutenantPack {
  final String name;
  final String assetName;

  const LieutenantPack._(this.name, this.assetName);

  static const LieutenantPack splig =
      const LieutenantPack._('Splig', 'splig.png');
  static const LieutenantPack belthir =
      const LieutenantPack._('Belthir', 'splig.png');
  static const LieutenantPack zachareth =
      const LieutenantPack._('Zachareth', 'splig.png');

  static List<LieutenantPack> values = [
    splig,
    belthir,
    zachareth,
  ];

  String get assetPath => 'lib/assets/lieutenants/$assetName';
}
