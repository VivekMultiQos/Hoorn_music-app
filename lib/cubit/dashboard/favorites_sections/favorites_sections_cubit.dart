import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';

part 'favorites_sections_state.dart';

class FavoritesSectionsCubit extends Cubit<FavoritesSectionsState> {
  FavoritesSectionsCubit() : super(FavoritesSectionsInitial());

  void uiUpdate() {
    emit(FavoritesSuccessState());
  }
}
