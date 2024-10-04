import 'package:flutter/material.dart';
import 'package:music_app/common/login_user.dart';
import 'package:music_app/constant/import.dart';
import 'package:music_app/cubit/dashboard/playing_song/playing_song_cubit.dart';
import 'package:music_app/entities/albums/mdl_album_details.dart';
import 'package:music_app/ui/dashboard/song_tail.dart';

class SongList extends StatefulWidget {
  final List<Songs> songs;
  final Function(int)? onTap;

  const SongList({super.key, required this.songs, this.onTap});

  @override
  State<SongList> createState() => _SongListState();
}

class _SongListState extends State<SongList> {
  String? playingSongId;

  @override
  void initState() {
    LoginUser.instance.currentPlayingSong.listen((value) {
      playingSongId = value.id;
      setState(() {});
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      shrinkWrap: true,
      physics: const NeverScrollableScrollPhysics(),
      itemCount: widget.songs.length,
      itemBuilder: (BuildContext context, int index) {
        return InkWell(
          onTap: () {
            var callBack = widget.onTap;
            if(callBack != null){
              callBack(index);
            }
          },
          child: SongTail(
            imageUrl: widget.songs.isNotEmpty
                ? widget.songs[index].image?.first.url ?? ''
                : '',
            songName: widget.songs[index].name ?? '',
            playCount: widget.songs[index].playCount?.toString() ?? '0',
            playingSongId: playingSongId ?? '',
            songId: widget.songs[index].id ?? '',
          ),
        );
      },
    );
  }
}
