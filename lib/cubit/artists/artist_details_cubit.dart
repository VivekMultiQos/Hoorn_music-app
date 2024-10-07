import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';
import 'package:music_app/entities/albums/mdl_album_details.dart';
import 'package:music_app/repository/contract_builder/app_repository_contract.dart';

part 'artist_details_state.dart';

class ArtistDetailsCubit extends Cubit<ArtistDetailsState> {
  final AppRepositoryContract repository;

  ArtistDetailsCubit({required this.repository})
      : super(ArtistDetailsInitial());

  void getArtist({bool shouldShowLoader = true, required String artistID}) async {
    emit(ArtistDetailsLoadingState());
    try {
      var response =
          await repository.getArtist(param: MDLGetLyricsParam(id: artistID));
      if (response.getException == null) {
        var dataInfo = response.getData;
        if (dataInfo != null) {
          emit(ArtistDetailsSuccessState(dataInfo));
        } else {
          emit(ArtistDetailsErrorState("Lyrics Not Found"));
        }
      } else {
        emit(ArtistDetailsErrorState("Lyrics Not Found"));
      }
    } on Exception catch (e) {
      emit(ArtistDetailsErrorState(e.toString()));
    }
  }
}
