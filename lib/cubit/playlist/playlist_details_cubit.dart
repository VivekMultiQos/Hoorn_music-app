import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';
import 'package:music_app/entities/albums/mdl_album_details.dart';

import '../../repository/contract_builder/app_repository_contract.dart';

part 'playlist_details_state.dart';

class PlaylistDetailsCubit extends Cubit<PlaylistDetailsState> {
  final AppRepositoryContract repository;

  PlaylistDetailsCubit({required this.repository})
      : super(PlaylistDetailsInitial());


  void getPlayList({bool shouldShowLoader = true, required int playListId}) async {
    emit(PlaylistDetailsLoadingState());
    try {
      var response =
      await repository.getPlayList(param: MDLGetAlbumsParam(id: playListId));
      if (response.getException == null) {
        var dataInfo = response.getData;
        if (dataInfo != null) {
          emit(PlaylistDetailsSuccessState(dataInfo));
        } else {
          emit(PlaylistDetailsErrorState('No albums found.'));
        }
      } else {
        emit(PlaylistDetailsErrorState('An error occurred'));
      }
    } on Exception catch (e) {
      emit(PlaylistDetailsErrorState(e.toString()));
    }
  }
}
