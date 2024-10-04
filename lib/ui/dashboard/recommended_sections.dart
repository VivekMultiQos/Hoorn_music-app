import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:music_app/common/login_user.dart';
import 'package:music_app/constant/import.dart';
import 'package:music_app/cubit/dashboard/favorites_sections/favorites_sections_cubit.dart';
import 'package:music_app/cubit/dashboard/playing_song/playing_song_cubit.dart';
import 'package:music_app/cubit/dashboard/recommended/recommended_section_cubit.dart';
import 'package:music_app/entities/albums/mdl_album_details.dart';
import 'package:music_app/ui/dashboard/song_tail.dart';

class RecommendedSections extends StatefulWidget {
  final ChangeThemeState themeState;
  final RecommendedSectionCubit recommendedSectionCubit;

  const RecommendedSections(
      {super.key,
      required this.themeState,
      required this.recommendedSectionCubit});

  @override
  State<RecommendedSections> createState() => _RecommendedSectionsState();
}

class _RecommendedSectionsState extends State<RecommendedSections> {
  String? playingSongId;

  @override
  void initState() {
    widget.recommendedSectionCubit.getSongs(songId: 'yDeAS8Eh');

    LoginUser.instance.currentPlayingSong.listen((value) {
      playingSongId = value.id;
    });

    LoginUser.instance.updateFavorites.listen((value) {});
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<RecommendedSectionCubit, RecommendedSectionState>(
      bloc: widget.recommendedSectionCubit,
      listener: (context, state) {
        if (state is RecommendedLoadingState) {}
      },
      builder: (context, state) {
        List<List<Songs>> songSections =
            _splitListIntoChunks(LoginUser.instance.favoriteSong, 4);

        if (state is RecommendedLoadingState) {
          return SizedBox(
            height: 100.h,
            child: const Center(
              child: CircularProgressIndicator(),
            ),
          );
        }

        return Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  "Favorites",
                  style: TextStyle(fontSize: 24.w, fontWeight: FontWeight.bold),
                ),
                InkWell(
                  onTap: () {
                    LoginUser.instance.playingSong.value = MDlPlayingSongs(
                      songs: LoginUser.instance.favoriteSong,
                      currentPlayingIndex: 0,
                    );
                  },
                  child: Text(
                    "Play all",
                    style: AppFontStyle.h3Regular.copyWith(
                      color: Colors.green,
                    ),
                  ),
                )
              ],
            ),
            SizedBox(
              height: 300.h,
              child: ListView.builder(
                scrollDirection: Axis.horizontal,
                itemCount: songSections.length,
                itemBuilder: (context, sectionIndex) {
                  return Column(
                    children: [
                      for (var song in songSections[sectionIndex])
                        SizedBox(
                          width: Get.width - 30.w,
                          child: InkWell(
                            onTap: () {
                              int currentIndex =
                                  LoginUser.instance.favoriteSong.indexOf(song);
                              LoginUser.instance.playingSong.value =
                                  MDlPlayingSongs(
                                songs: LoginUser.instance.favoriteSong,
                                currentPlayingIndex: currentIndex,
                              );
                            },
                            child: _buildSongItem(song),
                          ),
                        ),
                    ],
                  );
                },
              ),
            ),
          ],
        );
      },
    );
  }

  List<List<Songs>> _splitListIntoChunks(List<Songs> list, int chunkSize) {
    List<List<Songs>> chunks = [];
    for (var i = 0; i < list.length; i += chunkSize) {
      chunks.add(list.sublist(
          i, i + chunkSize > list.length ? list.length : i + chunkSize));
    }
    return chunks;
  }

  Widget _buildSongItem(Songs song) {
    return SongTail(
      imageUrl:
          song.image?.isNotEmpty ?? false ? song.image?.first.url ?? '' : '',
      songName: song.name ?? '',
      playCount: song.playCount.toString(),
      playingSongId: playingSongId ?? '',
      songId: song.id ?? '',
    );
  }
}
