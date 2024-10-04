import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';

import '../../entities/albums/mdl_search_album_response.dart';
import '../../repository/contract_builder/app_repository_contract.dart';

part 'dashboard_state.dart';

class DashboardCubit extends Cubit<DashboardState> {
  final AppRepositoryContract repository;

  DashboardCubit({required this.repository}) : super(DashboardInitial());



  void albumsList({bool shouldShowLoader = true}) async {
    emit(DashboardLoadingState());
    try {

      var response = await repository.searchAlbum(param: MDLAlbumsParam(query: "Evolve"));

      if (response.getException == null) {
        var dataInfo = response.getData;
        if (dataInfo != null) {
          emit(DashboardSuccessState(dataInfo));
        } else {
          emit(DashboardErrorState('No albums found.'));
        }
      } else {
        emit(DashboardErrorState('An error occurred'));
      }
    } on Exception catch (e) {
      emit(DashboardErrorState(e.toString()));
    }
  }
}
