import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';
import 'package:music_app/entities/albums/mdl_album_details.dart';

import '../../../repository/contract_builder/app_repository_contract.dart';

part 'play_screen_state.dart';

class PlayScreenCubit extends Cubit<PlayScreenState> {
  final AppRepositoryContract repository;

  PlayScreenCubit({required this.repository}) : super(PlayScreenInitial());

  void getLyrics({bool shouldShowLoader = true, required String songId}) async {
    emit(PlayScreenLoadingState());
    try {
      var response =
          await repository.getLyrics(param: MDLGetLyricsParam(id: songId));
      if (response.getException == null) {
        var dataInfo = response.getData;
        if (dataInfo != null) {
          emit(PlayScreenSuccessState(dataInfo.data?.lyrics ?? ''));
        } else {
          emit(PlayScreenErrorState("Lyrics Not Found"));
        }
      } else {
        emit(PlayScreenErrorState("Lyrics Not Found"));
      }
    } on Exception catch (e) {
      emit(PlayScreenErrorState(e.toString()));
    }
  }
}
