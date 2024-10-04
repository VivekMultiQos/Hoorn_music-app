part of 'play_screen_cubit.dart';

@immutable
sealed class PlayScreenState {}

final class PlayScreenInitial extends PlayScreenState {}

class PlayScreenLoadingState extends PlayScreenState {}

class PlayScreenSuccessState extends PlayScreenState {
  final String lyrics;

  PlayScreenSuccessState(this.lyrics);

}

class PlayScreenErrorState extends PlayScreenState {
  final String errorMessage;

  PlayScreenErrorState(this.errorMessage);
}
