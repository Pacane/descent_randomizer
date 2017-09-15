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

class UpdateTraitFilterAction {
  final Trait trait;
  final bool value;

  UpdateTraitFilterAction(this.trait, this.value);
}

class UpdateExpansionFilterAction {
  final Expansion expansion;

  UpdateExpansionFilterAction(this.expansion);
}

class UpdateLieutenantsFiltersAction {
  final LieutenantPack lieutenantPack;

  UpdateLieutenantsFiltersAction(this.lieutenantPack);
}

class ChangeNumberOfGroupsAction {
  final int number;

  ChangeNumberOfGroupsAction(this.number);
}

class ClearTraitsFilters {}

class DrawMonsterGroups {}

AppState filtersReducer(AppState state, dynamic action) {
  state = state.clone();
  if (action is UpdateTraitFilterAction) {
    state.traitsFilters[action.trait] = action.value;
  } else if (action is ChangeNumberOfGroupsAction) {
    state.numberOfGroups = action.number;
  } else if (action is DrawMonsterGroups) {
    state.foundMonsters = randomizeMonsterBy(state.numberOfGroups,
        traits: getAllEnabled(state.traitsFilters),
        expansions: getAllEnabled(state.expansionsFilters));
  } else if (action is UpdateExpansionFilterAction) {
    var oldValue = state.expansionsFilters[action.expansion];
    state.expansionsFilters[action.expansion] = !oldValue;
  } else if (action is UpdateLieutenantsFiltersAction) {
    var oldValue = state.lieutenantsFilters[action.lieutenantPack];
    state.lieutenantsFilters[action.lieutenantPack] = !oldValue;
  } else if (action is ClearTraitsFilters) {
    state.traitsFilters
        .forEach((Trait k, bool v) => state.traitsFilters[k] = false);
  }

  return state;
}
