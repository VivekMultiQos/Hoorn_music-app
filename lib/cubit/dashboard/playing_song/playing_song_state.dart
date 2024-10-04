part of 'playing_song_cubit.dart';

@immutable
sealed class PlayingSongState {}

final class PlayingSongInitial extends PlayingSongState {}
class PlayingSongLoadingState extends PlayingSongState {}
class PlayingSongUiUpdateState extends PlayingSongState {}

class PlayingSongSuccessState extends PlayingSongState {
  final Songs songs;

  PlayingSongSuccessState(this.songs);
}

class PlayingSongErrorState extends PlayingSongState {
  final String errorMessage;

  PlayingSongErrorState(this.errorMessage);
}
