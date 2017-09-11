import '../randomizer.dart';

class AppState {
  Map<Trait, bool> traitsFilters;
  int numberOfGroups;
  List<Monster> foundMonsters;

  AppState clone() {
    var newState = new AppState._(new Map.from(traitsFilters), numberOfGroups,
        new List.from(foundMonsters));
    return newState;
  }

  AppState.initial()
      : numberOfGroups = 2,
        traitsFilters = {},
        foundMonsters = [] {
    for (var trait in Trait.values) {
      traitsFilters[trait] = false;
    }
  }

  AppState._(this.traitsFilters, this.numberOfGroups, this.foundMonsters);
}

class UpdateTraitFilterAction {
  final Trait trait;
  final bool value;

  UpdateTraitFilterAction(this.trait, this.value);
}

class ChangeNumberOfGroupsAction {
  final int number;

  ChangeNumberOfGroupsAction(this.number);
}

class DrawMonsterGroups {}

AppState filtersReducer(AppState state, dynamic action) {
  if (action is UpdateTraitFilterAction) {
    state = state.clone();
    state.traitsFilters[action.trait] = action.value;
  } else if (action is ChangeNumberOfGroupsAction) {
    state = state.clone();
    state.numberOfGroups = action.number;
  } else if (action is DrawMonsterGroups) {
    state = state.clone();
    state.foundMonsters = randomizeMonsterBy(state.numberOfGroups,
        traits: state.traitsFilters.keys
            .where((Trait t) => state.traitsFilters[t] == true).toList());
  }

  return state;
}
