import 'package:bloc/bloc.dart';
import 'package:dio/dio.dart';
import 'package:meta/meta.dart';
import 'package:music_app/entities/albums/mdl_album_details.dart';
import 'package:music_app/entities/albums/mdl_search_album_response.dart';
import 'package:music_app/repository/contract_builder/app_repository_contract.dart';

part 'search_state.dart';

class SearchCubit extends Cubit<SearchState> {
  final AppRepositoryContract repository;

  SearchCubit({required this.repository}) : super(SearchInitial());

  CancelToken? _cancelTokenAlbum;
  CancelToken? _cancelTokenSong;

  void albumsList(
      {bool shouldShowLoader = true, required String searchText}) async {
    emit(SearchLoadingState());
    try {
      if (_cancelTokenAlbum != null) {
        _cancelTokenAlbum!.cancel('**Friends list cancelled**');
        _cancelTokenAlbum = null;
      }
      _cancelTokenAlbum = CancelToken();

      var response = await repository.searchAlbum(
        param: MDLAlbumsParam(query: searchText),
        cancelToken: _cancelTokenAlbum ?? CancelToken(),
      );

      if (response.getException == null) {
        var dataInfo = response.getData;
        if (dataInfo != null) {
          emit(SearchSuccessState(dataInfo));
        } else {
          emit(SearchErrorState('No albums found.'));
        }
      } else {
        emit(SearchErrorState('An error occurred'));
      }
    } on Exception catch (e) {
      emit(SearchErrorState(e.toString()));
    }
  }

  void songList(
      {bool shouldShowLoader = true, required String searchText}) async {
    emit(SearchLoadingState());
    try {
      if (_cancelTokenSong != null) {
        _cancelTokenSong!.cancel('**Friends list cancelled**');
        _cancelTokenSong = null;
      }
      _cancelTokenSong = CancelToken();

      var response = await repository.searchSongs(
        param: MDLAlbumsParam(query: searchText),
        cancelToken: _cancelTokenSong ?? CancelToken(),
      );

      if (response.getException == null) {
        var dataInfo = response.getData;
        if (dataInfo != null) {
          emit(SearchSongSuccessState(dataInfo.data?.results ?? []));
        } else {
          emit(SearchErrorState('No albums found.'));
        }
      } else {
        emit(SearchErrorState('An error occurred'));
      }
    } on Exception catch (e) {
      emit(SearchErrorState(e.toString()));
    }
  }
}
