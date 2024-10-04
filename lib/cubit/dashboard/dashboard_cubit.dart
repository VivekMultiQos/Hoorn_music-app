import 'package:bloc/bloc.dart';
import 'package:dio/dio.dart';
import 'package:meta/meta.dart';
import 'package:music_app/entities/albums/mdl_album_details.dart';

import '../../entities/albums/mdl_search_album_response.dart';
import '../../repository/contract_builder/app_repository_contract.dart';

part 'dashboard_state.dart';

class DashboardCubit extends Cubit<DashboardState> {
  final AppRepositoryContract repository;

  DashboardCubit({required this.repository}) : super(DashboardInitial());
  CancelToken? _cancelTokenAlbumList;
  CancelToken? _cancelTokenPlayList;

  void albumsList({bool shouldShowLoader = true}) async {
    emit(DashboardLoadingState());
    try {
      if (_cancelTokenAlbumList != null) {
        _cancelTokenAlbumList!.cancel('**Friends list cancelled**');
        _cancelTokenAlbumList = null;
      }
      _cancelTokenAlbumList = CancelToken();

      var response = await repository.searchAlbum(
        param: MDLAlbumsParam(query: "Evolve"),
        cancelToken: _cancelTokenAlbumList ?? CancelToken(),
      );

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

  void playListList({bool shouldShowLoader = true}) async {
    emit(DashboardLoadingState());
    try {
      if (_cancelTokenPlayList != null) {
        _cancelTokenPlayList!.cancel('**Friends list cancelled**');
        _cancelTokenPlayList = null;
      }
      _cancelTokenPlayList = CancelToken();

      var response = await repository.searchPlayList(
        param: MDLAlbumsParam(query: "Indie"),
        cancelToken: _cancelTokenPlayList ?? CancelToken(),
      );

      if (response.getException == null) {
        var dataInfo = response.getData;
        if (dataInfo != null) {
          emit(DashboardPlayListSuccessState(dataInfo));
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
