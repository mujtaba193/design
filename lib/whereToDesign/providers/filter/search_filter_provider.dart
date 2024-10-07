import 'package:flutter_riverpod/flutter_riverpod.dart';

final searchFilterProvider =
    StateNotifierProvider<SearchFilterProvider, SearchFilterState>(
  (ref) => SearchFilterProvider(),
);

class SearchFilterState {
  double timeValue2;
  final DateTime userTimeNow2;

  SearchFilterState({required this.timeValue2, required this.userTimeNow2});

  SearchFilterState copyWith({double? timeValue2, DateTime? userTimeNow2}) {
    return SearchFilterState(
      timeValue2: timeValue2 ?? this.timeValue2,
      userTimeNow2: userTimeNow2 ?? this.userTimeNow2,
    );
  }
}

////////////////////////////////
class SearchFilterProvider extends StateNotifier<SearchFilterState> {
  SearchFilterProvider()
      : super(SearchFilterState(
            timeValue2: 1.0, userTimeNow2: DateTime.now().toLocal()));

  void subtractTime() {
    if (state.timeValue2 > 1.0) {
      state = state.copyWith(
        timeValue2: state.timeValue2 - 0.5,
        userTimeNow2: state.userTimeNow2.subtract(Duration(minutes: 30)),
      );
    }
  }

  void addTime() {
    state = state.copyWith(
      timeValue2: state.timeValue2 + 0.5,
      userTimeNow2: state.userTimeNow2.add(Duration(minutes: 30)),
    );
  }
}
