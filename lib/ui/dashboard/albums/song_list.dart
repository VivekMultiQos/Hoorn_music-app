import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:loading_animation_widget/loading_animation_widget.dart';
import 'package:music_app/common/login_user.dart';
import 'package:music_app/constant/import.dart';
import 'package:music_app/entities/albums/mdl_album_details.dart';
import 'package:music_app/ui/dashboard/song_tail.dart';

class SongList extends StatefulWidget {
  final bool? singles;
  final List<Songs> songs;
  final Function(int)? onTap;

  const SongList({super.key, required this.songs, this.onTap, this.singles});

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
    if (widget.singles ?? false) {
      return SizedBox(
        height: 200.h,
        child: ListView.builder(
          shrinkWrap: true,
          scrollDirection: Axis.horizontal,
          itemCount: widget.songs.length,
          itemBuilder: (BuildContext context, int index) {
            return InkWell(
              onTap: () {
                var callBack = widget.onTap;
                if (callBack != null) {
                  callBack(index);
                }
              },
              child: singlesTail(
                image: widget.songs.isNotEmpty
                    ? widget.songs[index].image?.last.url ?? ''
                    : '',
                name: widget.songs[index].name ?? '',
                playingSongId: playingSongId ?? '',
                songId: widget.songs[index].id ?? '',
              ),
            );
          },
        ),
      );
    }
    return ListView.builder(
      shrinkWrap: true,
      physics: const NeverScrollableScrollPhysics(),
      scrollDirection: Axis.vertical,
      itemCount: widget.songs.length,
      itemBuilder: (BuildContext context, int index) {
        return InkWell(
            onTap: () {
              var callBack = widget.onTap;
              if (callBack != null) {
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
            ));
      },
    );
  }

  Widget singlesTail(
      {required String image,
      required String name,
      required String playingSongId,
      required String songId}) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Column(
        children: [
          Stack(
            children: [
              CachedNetworkImage(
                imageUrl: image,
                height: 150.w,
                width: 150.w,
                errorWidget: (context, url, error) => const Icon(Icons.error),
              ),
              if (playingSongId == songId)
                SizedBox(
                  height: 150.w,
                  width: 150.w,
                  child: Center(
                    child: LoadingAnimationWidget.staggeredDotsWave(
                        color: Colors.green, size: 40.w),
                  ),
                )
            ],
          ),
          SizedBox(
            width: 150.w,
            child: Text(
              name,
              maxLines: 1,
              overflow: TextOverflow.ellipsis,
              textAlign: TextAlign.center,
            ),
          ),
        ],
      ),
    );
  }
}
