part of 'album_details_cubit.dart';

@immutable
sealed class AlbumDetailsState {}

class AlbumDetailsInitial extends AlbumDetailsState {}

class AlbumDetailsLoadingState extends AlbumDetailsState {}

class AlbumDetailsSuccessState extends AlbumDetailsState {
  final MdlAlbumDetails mdlAlbumDetails;

  AlbumDetailsSuccessState(this.mdlAlbumDetails);

}

class AlbumDetailsErrorState extends AlbumDetailsState {
  final String errorMessage;

  AlbumDetailsErrorState(this.errorMessage);
}
