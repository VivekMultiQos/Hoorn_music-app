part of 'artist_details_cubit.dart';

@immutable
sealed class ArtistDetailsState {}

final class ArtistDetailsInitial extends ArtistDetailsState {}

class ArtistDetailsLoadingState extends ArtistDetailsState {}

class ArtistDetailsSuccessState extends ArtistDetailsState {
  final ADLArtistResponse mdlArtistResponse;

  ArtistDetailsSuccessState(this.mdlArtistResponse);
}

class ArtistDetailsErrorState extends ArtistDetailsState {
  final String errorMessage;

  ArtistDetailsErrorState(this.errorMessage);
}
