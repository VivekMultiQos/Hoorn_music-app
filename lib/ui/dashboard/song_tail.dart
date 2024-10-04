import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:loading_animation_widget/loading_animation_widget.dart';
import 'package:music_app/constant/import.dart';

class SongTail extends StatefulWidget {
  final String imageUrl;
  final String songName;
  final String playCount;
  final String playingSongId;
  final String songId;

  const SongTail(
      {super.key,
      required this.imageUrl,
      required this.songName,
      required this.playCount,
      required this.playingSongId,
      required this.songId});

  @override
  State<SongTail> createState() => _SongTailState();
}

class _SongTailState extends State<SongTail> {
  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(10.w),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Expanded(
            child: Row(
              children: [
                CachedNetworkImage(
                  imageUrl: widget.imageUrl,
                  errorWidget: (context, url, error) => const Icon(Icons.error),
                ),
                SizedBox(
                  width: 10.w,
                ),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        widget.songName,
                        style: AppFontStyle.h2SemiBold,
                        maxLines: 1,
                        overflow:
                            TextOverflow.ellipsis, // Ellipsis for overflow
                      ),
                      SizedBox(
                        height: 5.h,
                      ),
                      Text(
                        "${widget.playCount} plays",
                        style:
                            AppFontStyle.h4Medium.copyWith(color: Colors.grey),
                        maxLines: 1,
                        overflow:
                            TextOverflow.ellipsis, // Ellipsis for overflow
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
          SizedBox(
            width: 10.w,
          ),
          if (widget.playingSongId == widget.songId)
            LoadingAnimationWidget.staggeredDotsWave(
              color: Colors.green,
              size: 40.w
            )
        ],
      ),
    );
  }
}
