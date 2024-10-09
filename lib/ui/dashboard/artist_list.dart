import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:music_app/constant/import.dart';
import 'package:music_app/entities/albums/mdl_album_details.dart';
import 'package:music_app/entities/albums/mdl_album_details_screen.dart';
import 'package:music_app/entities/artist/mdl_artist_screen.dart';
import 'package:music_app/entities/playList/mdl_play_list_screen.dart';

import '../../entities/albums/mdl_search_album_response.dart';

class ArtistList extends StatefulWidget {
  final List<PlayListArtists> artistList;

  const ArtistList({super.key, required this.artistList});

  @override
  State<ArtistList> createState() => _ArtistListState();
}

class _ArtistListState extends State<ArtistList> {
  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.start,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        widget.artistList.isNotEmpty
            ? Padding(
                padding: EdgeInsets.symmetric(horizontal: 10.w),
                child: Text(
                  "Artists",
                  style: AppFontStyle.h2Bold,
                ),
              )
            : const SizedBox.shrink(),
        SizedBox(
          height: 220.w,
          child: ListView.builder(
            scrollDirection: Axis.horizontal,
            itemCount: widget.artistList.length,
            itemBuilder: (BuildContext context, int index) {
              return Padding(
                padding: const EdgeInsets.all(8.0),
                child: InkWell(
                  onTap: () {
                    Get.back();
                    Get.toNamed(
                      AppPages.artistDetails,
                      arguments: MdlArtistDetailsScreen(
                          artistId: int.tryParse(
                            widget.artistList[index].id ?? '',
                          ),
                          artistName: widget.artistList[index].name),
                    );
                  },
                  child: Column(
                    children: [
                      Container(
                        clipBehavior: Clip.hardEdge,
                        decoration: const BoxDecoration(
                          shape: BoxShape.circle,
                        ),
                        child: widget.artistList[index].image?.isNotEmpty ??
                                false
                            ? CachedNetworkImage(
                                imageUrl:
                                    widget.artistList[index].image?.last.url ??
                                        '',
                                height: 150.w,
                                width: 150.w,
                                errorWidget: (context, url, error) =>
                                    const Icon(Icons.error),
                              )
                            : Image.asset(
                                AssetImages.placeholder,
                                height: 150.w,
                                width: 150.w,
                              ),
                      ),
                      SizedBox(
                        width: 150.w,
                        child: Text(
                          widget.artistList[index].name ?? '',
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
