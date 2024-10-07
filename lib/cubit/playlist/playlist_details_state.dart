part of 'playlist_details_cubit.dart';

@immutable
sealed class PlaylistDetailsState {}

final class PlaylistDetailsInitial extends PlaylistDetailsState {}

class PlaylistDetailsLoadingState extends PlaylistDetailsState {}

class PlaylistDetailsSuccessState extends PlaylistDetailsState {
  final MDlPlayListResponse mDlPlayListResponse;

  PlaylistDetailsSuccessState(this.mDlPlayListResponse);
}

class PlaylistDetailsErrorState extends PlaylistDetailsState {
  final String errorMessage;

  PlaylistDetailsErrorState(this.errorMessage);
}
