import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:music_app/constant/import.dart';
import 'package:music_app/entities/albums/mdl_album_details_screen.dart';

import '../../entities/albums/mdl_search_album_response.dart';

class AlbumList extends StatefulWidget {
  final List<MDLAlbumsListResults> albumList;

  const AlbumList({super.key, required this.albumList});

  @override
  State<AlbumList> createState() => _AlbumListState();
}

class _AlbumListState extends State<AlbumList> {
  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.start,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        widget.albumList.isNotEmpty
            ? Padding(
                padding: EdgeInsets.symmetric(horizontal: 10.w),
                child: Text(
                  "Albums",
                  style: AppFontStyle.h2Bold,
                ),
              )
            : const SizedBox.shrink(),
        SizedBox(
          height: 230.w,
          child: ListView.builder(
            scrollDirection: Axis.horizontal,
            itemCount: widget.albumList.length,
            itemBuilder: (BuildContext context, int index) {
              return Padding(
                padding: const EdgeInsets.all(8.0),
                child: InkWell(
                  onTap: () {
                    Get.toNamed(
                      AppPages.albumDetails,
                      arguments: MdlAlbumDetailsScreen(
                          albumId: int.tryParse(
                            widget.albumList[index].id ?? '',
                          ),
                          albumName: widget.albumList[index].name),
                    );
                  },
                  child: Column(
                    children: [
                      CachedNetworkImage(
                        imageUrl: widget.albumList[index].image?[1].url ?? '',
                        fit: BoxFit.cover,
                        errorWidget: (context, url, error) => Image.network(
                          'https://www.wagbet.com/wp-content/uploads/2019/11/music_placeholder.png',
                          fit: BoxFit.cover,
                          width: 150.w,
                          height: 155.w,
                        ),
                      ),
                      SizedBox(
                        width: 150.w,
                        child: Text(
                          widget.albumList[index].name ?? '',
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
