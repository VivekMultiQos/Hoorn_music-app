abstract class PrefetchState {}

class PrefetchInitialState extends PrefetchState {}

class PrefetchLoadingState extends PrefetchState {
  final String message;

  PrefetchLoadingState({this.message = ''});
}

class PrefetchDropDownSuccessState extends PrefetchState {}

class PrefetchDropDownErrorState extends PrefetchState {
  final String errorMessage;
  PrefetchDropDownErrorState(this.errorMessage);
}
