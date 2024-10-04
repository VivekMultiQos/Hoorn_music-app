import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';
import 'package:music_app/entities/albums/mdl_album_details.dart';
import 'package:music_app/repository/contract_builder/app_repository_contract.dart';

part 'album_details_state.dart';

class AlbumDetailsCubit extends Cubit<AlbumDetailsState> {
  final AppRepositoryContract repository;

  AlbumDetailsCubit({required this.repository}) : super(AlbumDetailsInitial());

  void getAlbums({bool shouldShowLoader = true, required int albumId}) async {
    emit(AlbumDetailsLoadingState());
    try {
      var response =
          await repository.getAlbum(param: MDLGetAlbumsParam(id: albumId));
      if (response.getException == null) {
        var dataInfo = response.getData;
        if (dataInfo != null) {
          emit(AlbumDetailsSuccessState(dataInfo));
        } else {
          emit(AlbumDetailsErrorState('No albums found.'));
        }
      } else {
        emit(AlbumDetailsErrorState('An error occurred'));
      }
    } on Exception catch (e) {
      emit(AlbumDetailsErrorState(e.toString()));
    }
  }
}
