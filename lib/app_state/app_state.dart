import '../randomizer.dart';
import '../descent.dart';
import '../utils.dart';

class AppState {
  Map<Trait, bool> traitsFilters;
  int numberOfGroups;
  List<Monster> foundMonsters;
  Map<Expansion, bool> expansionsFilters;
  Map<LieutenantPack, bool> lieutenantsFilters;

  AppState.initial()
      : numberOfGroups = 2,
        traitsFilters = {},
        foundMonsters = [],
        expansionsFilters = {},
        lieutenantsFilters = {} {
    for (var trait in Trait.values) {
      traitsFilters[trait] = false;
    }

    for (var expansion in Expansion.values) {
      if (expansion == Expansion.base) {
        expansionsFilters[expansion] = true;
      } else {
        expansionsFilters[expansion] = false;
      }
    }

    for (var lieutenant in LieutenantPack.values) {
      lieutenantsFilters[lieutenant] = false;
    }
  }

  AppState._(
    this.traitsFilters,
    this.numberOfGroups,
    this.foundMonsters,
    this.expansionsFilters,
    this.lieutenantsFilters,
  );

  AppState clone() {
    var newState = new AppState._(
      new Map.from(traitsFilters),
      numberOfGroups,
      new List.from(foundMonsters),
      new Map.from(expansionsFilters),
      new Map.from(lieutenantsFilters),
    );
    return newState;
  }
}

abstract class IsAction {
  AppState handle(AppState state);
}

class UpdateTraitFilterAction extends Object with IsAction {
  final Trait trait;
  final bool value;

  UpdateTraitFilterAction(this.trait, this.value);

  @override
  AppState handle(AppState state) {
    state.traitsFilters[trait] = value;
    return state;
  }
}

class UpdateExpansionFilterAction extends Object with IsAction {
  final Expansion expansion;

  UpdateExpansionFilterAction(this.expansion);

  @override
  AppState handle(AppState state) {
    var oldValue = state.expansionsFilters[expansion];
    state.expansionsFilters[expansion] = !oldValue;
    return state;
  }
}

class UpdateLieutenantsFiltersAction extends Object with IsAction {
  final LieutenantPack lieutenantPack;

  UpdateLieutenantsFiltersAction(this.lieutenantPack);

  @override
  AppState handle(AppState state) {
    var oldValue = state.lieutenantsFilters[lieutenantPack];
    state.lieutenantsFilters[lieutenantPack] = !oldValue;
    return state;
  }
}

class ChangeNumberOfGroupsAction extends Object with IsAction {
  final int number;

  ChangeNumberOfGroupsAction(this.number);

  @override
  AppState handle(AppState state) {
    state.numberOfGroups = number;
    return state;
  }
}

class ClearTraitsFilters extends Object with IsAction {
  @override
  AppState handle(AppState state) {
    state.traitsFilters
        .forEach((Trait k, bool v) => state.traitsFilters[k] = false);
    return state;
  }
}

class DrawMonsterGroups extends Object with IsAction {
  @override
  AppState handle(AppState state) {
    state.foundMonsters = randomizeMonsterBy(state.numberOfGroups,
        traits: getAllEnabled(state.traitsFilters),
        expansions: getAllEnabled(state.expansionsFilters));
    return state;
  }
}

AppState filtersReducer<T extends IsAction>(AppState state, T action) {
  state = state.clone();
  state = action.handle(state);

  return state;
}
