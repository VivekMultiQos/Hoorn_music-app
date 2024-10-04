part of 'search_cubit.dart';

@immutable
sealed class SearchState {}

final class SearchInitial extends SearchState {}

class SearchLoadingState extends SearchState {}

class SearchSuccessState extends SearchState {
  final MdlSearchAlbumResponse mdlSearchAlbumResponse;

  SearchSuccessState(this.mdlSearchAlbumResponse);
}

class SearchSongSuccessState extends SearchState {
  final List<Songs> mdlSearchAlbumResponse;

  SearchSongSuccessState(this.mdlSearchAlbumResponse);
}


class SearchErrorState extends SearchState {
  final String errorMessage;

  SearchErrorState(this.errorMessage);
}
