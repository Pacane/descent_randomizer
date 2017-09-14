import '../randomizer.dart';
import '../descent.dart';
import '../utils.dart';

class AppState {
  Map<Trait, bool> traitsFilters;
  int numberOfGroups;
  List<Monster> foundMonsters;
  Map<Expansion, bool> expansionsFilters;

  AppState clone() {
    var newState = new AppState._(
      new Map.from(traitsFilters),
      numberOfGroups,
      new List.from(foundMonsters),
      new Map.from(expansionsFilters),
    );
    return newState;
  }

  AppState.initial()
      : numberOfGroups = 2,
        traitsFilters = {},
        foundMonsters = [],
        expansionsFilters = {} {
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
  }

  AppState._(this.traitsFilters, this.numberOfGroups, this.foundMonsters,
      this.expansionsFilters);
}

class UpdateTraitFilterAction {
  final Trait trait;
  final bool value;

  UpdateTraitFilterAction(this.trait, this.value);
}

class UpdateExpansionFilterAction {
  final Expansion expansion;
  final bool value;

  UpdateExpansionFilterAction(this.expansion, this.value);
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
    state.expansionsFilters[action.expansion] = action.value;
  } else if (action is ClearTraitsFilters) {
    state.traitsFilters
        .forEach((Trait k, bool v) => state.traitsFilters[k] = false);
  }

  return state;
}
