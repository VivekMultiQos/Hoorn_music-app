import 'dart:convert';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get/get.dart';
import 'package:music_app/common/login_user.dart';
import 'package:music_app/common/util.dart';
import 'package:music_app/constant/import.dart';
import 'package:music_app/cubit/artists/artist_details_cubit.dart';
import 'package:music_app/cubit/dashboard/playing_song/playing_song_cubit.dart';
import 'package:music_app/entities/albums/mdl_album_details.dart';
import 'package:music_app/entities/artist/mdl_artist_screen.dart';
import 'package:music_app/ui/dashboard/album_list.dart';
import 'package:music_app/ui/dashboard/albums/song_list.dart';
import 'package:music_app/ui/dashboard/artist_list.dart';
import 'package:music_app/ui/prefere_screen.dart';

import '../../../entities/albums/mdl_local_store.dart';

class ArtistDetailsScreen extends StatefulWidget {
  final ArtistDetailsCubit artistDetailsCubit;

  const ArtistDetailsScreen({super.key, required this.artistDetailsCubit});

  @override
  State<ArtistDetailsScreen> createState() => _ArtistDetailsScreenState();
}

class _ArtistDetailsScreenState extends State<ArtistDetailsScreen> {
  bool isPlaying = false;
  MDlArtistData mdlArtistData = MDlArtistData();

  @override
  void initState() {
    if (Get.arguments is MdlArtistDetailsScreen) {
      var mdlArtistData = Get.arguments as MdlArtistDetailsScreen;
      widget.artistDetailsCubit
          .getArtist(artistID: mdlArtistData.artistId.toString() ?? '');
    }

    LoginUser.instance.songPlay.listen((value) {
      isPlaying = value;
      setState(() {});
    });

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<ThemeCubit, ChangeThemeState>(
      bloc: changeThemeCubit,
      builder: (context, themeState) {
        return BlocConsumer<ArtistDetailsCubit, ArtistDetailsState>(
          bloc: widget.artistDetailsCubit,
          listener: (context, state) {
            if (state is ArtistDetailsSuccessState) {
              mdlArtistData = state.mdlArtistResponse.data ?? MDlArtistData();
            }
          },
          builder: (context, state) {
            if (state is ArtistDetailsLoadingState) {
              return Container(
                decoration: BoxDecoration(
                  gradient: screenBackGroundColor(),
                ),
                child: const Center(
                  child: CircularProgressIndicator(),
                ),
              );
            }

            return Scaffold(
              appBar: baseAppBar(
                leading: const BackButton(),
              ),
              body: Container(
                decoration: BoxDecoration(
                  gradient: screenBackGroundColor(),
                ),
                child: SingleChildScrollView(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      Stack(
                        children: [
                          mdlArtistData.image?.isNotEmpty ?? false
                              ? Container(
                                  foregroundDecoration: const BoxDecoration(
                                    gradient: LinearGradient(
                                      colors: [
                                        Colors.transparent,
                                        Colors.transparent,
                                        Colors.black
                                      ],
                                      begin: Alignment.topCenter,
                                      end: Alignment.bottomCenter,
                                      stops: [0, 0.2, 1],
                                    ),
                                  ),
                                  child: CachedNetworkImage(
                                    imageUrl:
                                        mdlArtistData.image?.last.url ?? '',
                                    width: Get.width,
                                    errorWidget: (context, url, error) =>
                                        const Icon(Icons.error),
                                    fit: BoxFit.cover,
                                  ),
                                )
                              : Image.asset(
                                  AssetImages.placeholder,
                                  width: Get.width,
                                  fit: BoxFit.cover,
                                ),
                          Positioned(
                            bottom: 10,
                            left: 10,
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.start,
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Row(
                                  crossAxisAlignment: CrossAxisAlignment.center,
                                  children: [
                                    Text(
                                      mdlArtistData.name ?? '',
                                      style: AppFontStyle.h1Bold.copyWith(
                                        color: Colors.white,
                                      ),
                                    ),
                                    mdlArtistData.isVerified ?? false
                                        ? const Icon(
                                            Icons.verified,
                                            color: Colors.blue,
                                          )
                                        : const SizedBox.shrink(),
                                  ],
                                ),
                                Row(
                                  children: [
                                    const Icon(
                                      Icons.person,
                                      color: Colors.grey,
                                    ),
                                    Text(
                                      "${mdlArtistData.followerCount}",
                                      style: AppFontStyle.p1Medium
                                          .copyWith(color: Colors.grey),
                                    ),
                                  ],
                                ),
                                // mdlArtistData.bio?.isNotEmpty ?? false
                                //     ? Row(
                                //         children: [
                                //           Text(
                                //             mdlArtistData.bio?.first.text ??
                                //                 '',
                                //             style: AppFontStyle.h3Regular
                                //                 .copyWith(
                                //               color: Colors.white,
                                //             ),
                                //           ),
                                //         ],
                                //       )
                                //     : const SizedBox.shrink(),
                              ],
                            ),
                          )
                        ],
                      ),
                      SizedBox(
                        height: 10.w,
                      ),
                      mdlArtistData.topSongs?.isNotEmpty ?? false
                          ? albumPlaySection(songs: mdlArtistData.topSongs)
                          : const SizedBox.shrink(),
                      SongList(
                        songs: mdlArtistData.topSongs ?? [],
                        onTap: (value) {
                          LoginUser.instance.playingSong.value =
                              MDlPlayingSongs(
                                  songs: mdlArtistData.topSongs ?? [],
                                  currentPlayingIndex: value);
                          LoginUser.instance.currentPlayAlbumId =
                              mdlArtistData.id;
                        },
                      ),
                      mdlArtistData.topSongs?.isNotEmpty ?? false
                          ? Padding(
                              padding: EdgeInsets.symmetric(horizontal: 10.w),
                              child: Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  Text(
                                    "Singles",
                                    style: AppFontStyle.h2Bold,
                                  ),
                                  InkWell(
                                    onTap: () {
                                      LoginUser.instance.playingSong.value =
                                          MDlPlayingSongs(
                                        songs: mdlArtistData.singles ?? [],
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
                            )
                          : const SizedBox.shrink(),
                      SongList(
                        singles: true,
                        songs: mdlArtistData.singles ?? [],
                        onTap: (value) {
                          if (mdlArtistData
                                  .singles?[value].downloadUrl?.isNotEmpty ??
                              false) {
                            LoginUser.instance.playingSong.value =
                                MDlPlayingSongs(
                                    songs: mdlArtistData.singles ?? [],
                                    currentPlayingIndex: value);
                            LoginUser.instance.currentPlayAlbumId =
                                mdlArtistData.id;
                          } else {
                            showToastAlert(message: "song not available");
                          }
                        },
                      ),
                      AlbumList(albumList: mdlArtistData.topAlbums ?? []),
                      ArtistList(
                          artistList: mdlArtistData.similarArtists ?? []),
                      SizedBox(
                        height: 70.h,
                      )
                    ],
                  ),
                ),
              ),
            );
          },
        );
      },
    );
  }

  Widget albumPlaySection({List<Songs>? songs}) {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 10.w),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Row(
            children: [
              InkWell(
                onTap: () async {
                  var isAlreadyInList = LoginUser.instance.preferSinger
                      .any((singer) => singer.name == mdlArtistData.name);

                  if (isAlreadyInList) {
                    LoginUser.instance.preferSinger.removeWhere(
                        (singer) => singer.name == mdlArtistData.name);
                  } else {
                    LoginUser.instance.preferSinger.add(
                        Singers(name: mdlArtistData.name ?? '', image: ""));
                  }
                  await LoginUser.instance.storeUserDataToLocal(
                    MdlLocalStore(
                      favoriteSong: jsonEncode(LoginUser.instance.preferSinger
                          .map((singer) => singer.toJson())
                          .toList()),
                    ),
                  );

                  setState(() {});
                },
                child: Icon(
                  LoginUser.instance.preferSinger
                          .any((singer) => singer.name == mdlArtistData.name)
                      ? Icons.favorite
                      : Icons.favorite_border,
                  color: LoginUser.instance.preferSinger
                          .any((singer) => singer.name == mdlArtistData.name)
                      ? Colors.green
                      : Colors.black,
                ),
              ),
              SizedBox(
                width: 15.w,
              ),
              const Icon(Icons.download_for_offline_outlined),
              SizedBox(
                width: 15.w,
              ),
              const Icon(Icons.more_vert),
            ],
          ),
          Row(
            children: [
              const Icon(Icons.shuffle),
              SizedBox(
                width: 15.w,
              ),
              InkWell(
                onTap: () {
                  setState(() {
                    if (LoginUser.instance.player.playing &&
                        LoginUser.instance.currentPlayAlbumId ==
                            mdlArtistData.id) {
                      LoginUser.instance.player.pause();
                      LoginUser.instance.songPlay.value = false;
                    } else {
                      LoginUser.instance.player.play();
                      LoginUser.instance.songPlay.value = true;
                      if (LoginUser.instance.currentPlayAlbumId !=
                          mdlArtistData.id) {
                        LoginUser.instance.playingSong.value = MDlPlayingSongs(
                            songs: songs ?? [], currentPlayingIndex: 0);
                        LoginUser.instance.currentPlayAlbumId =
                            mdlArtistData.id;
                      }
                    }
                  });
                },
                child: Container(
                  padding: EdgeInsets.all(10.w),
                  decoration: const BoxDecoration(
                      color: Colors.green,
                      shape: BoxShape.circle,
                      boxShadow: [
                        BoxShadow(
                          color: Colors.black45,
                          blurRadius: 10,
                        )
                      ]),
                  child: Icon(LoginUser.instance.currentPlayAlbumId ==
                              mdlArtistData.id &&
                          isPlaying
                      ? Icons.pause
                      : Icons.play_arrow),
                ),
              ),
            ],
          )
        ],
      ),
    );
  }
}
