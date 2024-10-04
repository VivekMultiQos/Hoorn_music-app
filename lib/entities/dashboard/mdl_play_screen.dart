import 'package:music_app/entities/albums/mdl_album_details.dart';

class MdlPlayScreen {
  Songs songs;
  Function(bool)? hidePlayingWidget;
  Function? previous;
  Function? next;

  MdlPlayScreen(
      {required this.songs, this.hidePlayingWidget, this.previous, this.next});
}
