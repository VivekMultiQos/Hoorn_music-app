import 'dart:math';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:music_app/common/login_user.dart';
import 'package:music_app/common/util.dart';
import 'package:music_app/constant/import.dart';
import 'package:music_app/cubit/dashboard/favorites_sections/favorites_sections_cubit.dart';
import 'package:music_app/cubit/dashboard/playing_song/playing_song_cubit.dart';
import 'package:music_app/cubit/dashboard/recommended/recommended_section_cubit.dart';
import 'package:music_app/entities/albums/mdl_album_details.dart';
import 'package:music_app/repository/contract_builder/app_repository_builder.dart';
import 'package:music_app/repository/contract_builder/app_repository_contract.dart';
import 'package:music_app/ui/dashboard/song_tail.dart';

class RecommendedSections extends StatefulWidget {
  const RecommendedSections({super.key});

  @override
  State<RecommendedSections> createState() => _RecommendedSectionsState();
}

class _RecommendedSectionsState extends State<RecommendedSections> {
  String? playingSongId;
  List<Songs> recommendedSongs = [];

  RecommendedSectionCubit recommendedSectionCubit = RecommendedSectionCubit(
      repository: AppRepositoryBuilder.repository(
    of: RepositoryProviderType.home,
  ));

  @override
  void initState() {
    super.initState();
    // recommendedSectionCubit.getSongs(songId: LoginUser.instance.favoriteSong.last.id ?? '');

    fetchRandomSongId();
    LoginUser.instance.currentPlayingSong.listen((value) {
      playingSongId = value.id;
      setState(() {});
    });
  }

  void fetchRandomSongId() {
    List<String> favoriteSongs = LoginUser.instance.favoriteSong
        .map((song) => song.id)
        .where((id) => id != null)
        .cast<String>()
        .toList();

    if (favoriteSongs.isNotEmpty) {
      var randomIndex = Random().nextInt(favoriteSongs.length);
      String randomSongId = favoriteSongs[randomIndex];
      recommendedSectionCubit.getSongs(songId: randomSongId);
    } else {
      print('No favorite songs available');
    }
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<ThemeCubit, ChangeThemeState>(
      bloc: changeThemeCubit,
      builder: (context, themeState) {
        return BlocConsumer<RecommendedSectionCubit, RecommendedSectionState>(
            bloc: recommendedSectionCubit,
            listener: (context, state) {
              if (state is RecommendedErrorState) {
                fetchRandomSongId();
              }
              if (state is RecommendedSuccessState) {
                recommendedSongs = state.songs;
              } else if (state is RecommendedErrorState) {
                showToastAlert(message: state.errorMessage);
              }
            },
            buildWhen: (preState, curState) {
              return curState is RecommendedSuccessState;
            },
            builder: (context, state) {
              if (state is RecommendedSuccessState) {
                List<List<Songs>> songSections =
                    _splitListIntoChunks(recommendedSongs, 4);
                return Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          "Recommended Songs",
                          style: TextStyle(
                              fontSize: 24.w, fontWeight: FontWeight.bold),
                        ),
                        InkWell(
                          onTap: () {
                            LoginUser.instance.playingSong.value =
                                MDlPlayingSongs(
                              songs: recommendedSongs,
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
                                          recommendedSongs.indexOf(song);
                                      LoginUser.instance.playingSong.value =
                                          MDlPlayingSongs(
                                        songs: recommendedSongs,
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
              } else {
                return SizedBox(
                  height: 100.h,
                  child: const Center(
                    child: CircularProgressIndicator(),
                  ),
                );
              }
            });
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
