import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';
import 'package:music_app/entities/albums/mdl_album_details.dart';
import 'package:music_app/repository/contract_builder/app_repository_contract.dart';

part 'recommended_section_state.dart';

class RecommendedSectionCubit extends Cubit<RecommendedSectionState> {
  final AppRepositoryContract repository;

  RecommendedSectionCubit({required this.repository})
      : super(RecommendedSectionInitial());

  void getSongs({bool shouldShowLoader = true, required String songId}) async {
    emit(RecommendedLoadingState());
    try {
      var response = await repository.getSongs(param: MDLGetSongParam(id: songId, limit: 20));
      if (response.getException == null) {
        var dataInfo = response.getData;
        if (dataInfo != null) {
            emit(RecommendedSuccessState(dataInfo.data ?? []));
        } else {
          emit(RecommendedErrorState('No albums found.'));
        }
      } else {
        emit(RecommendedErrorState('An error occurred'));
      }
    } on Exception catch (e) {
      emit(RecommendedErrorState(e.toString()));
    }
  }
}
