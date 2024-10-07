import 'package:flutter/material.dart';
import 'package:music_app/constant/import.dart';
import 'package:music_app/entities/albums/mdl_album_details.dart';
import 'package:music_app/entities/albums/mdl_album_details_screen.dart';
import 'package:music_app/entities/playList/mdl_play_list_screen.dart';

import '../../entities/albums/mdl_search_album_response.dart';

class PlayListList extends StatefulWidget {
  final List<MDLPlayListResults> playListList;

  const PlayListList({super.key, required this.playListList});

  @override
  State<PlayListList> createState() => _PlayListListState();
}

class _PlayListListState extends State<PlayListList> {
  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.start,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        widget.playListList.isNotEmpty
            ? Padding(
                padding: EdgeInsets.symmetric(horizontal: 10.w),
                child: Text(
                  "Playlists",
                  style: AppFontStyle.h2Bold,
                ),
              )
            : const SizedBox.shrink(),
        SizedBox(
          height: 200.h,
          child: ListView.builder(
            scrollDirection: Axis.horizontal,
            itemCount: widget.playListList.length,
            itemBuilder: (BuildContext context, int index) {
              return Padding(
                padding: const EdgeInsets.all(8.0),
                child: InkWell(
                  onTap: () {
                    Get.toNamed(
                      AppPages.playListDetails,
                      arguments: MdlPlayListDetailsScreen(
                          playListId: int.tryParse(
                            widget.playListList[index].id ?? '',
                          ),
                          playListName: widget.playListList[index].name),
                    );
                  },
                  child: Column(
                    children: [
                      Image.network(
                        widget.playListList[index].image?[1].url ?? '',
                      ),
                      SizedBox(
                        width: 150.w,
                        child: Text(
                          widget.playListList[index].name ?? '',
                          maxLines: 1,
                          overflow: TextOverflow.ellipsis,
                          textAlign: TextAlign.center,
                        ),
                      ),
                    ],
                  ),
                ),
              );
            },
          ),
        ),
      ],
    );
  }
}
