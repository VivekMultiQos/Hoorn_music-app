import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';
import 'package:music_app/common/login_user.dart';
import 'package:music_app/entities/albums/mdl_album_details.dart';

part 'playing_song_state.dart';

class PlayingSongCubit extends Cubit<PlayingSongState> {
  PlayingSongCubit() : super(PlayingSongInitial());

  void updateSong({required Songs song}) {
    emit(PlayingSongSuccessState(song));
    LoginUser.instance.currentPlayingSong.value = song;
  }


  void updateUI({required Songs song}){
    LoginUser.instance.currentPlayingSong.value = song;
  }
}

class MDlPlayingSongs {
  List<Songs> songs;
  int currentPlayingIndex;

  MDlPlayingSongs({required this.songs, required this.currentPlayingIndex});
}
