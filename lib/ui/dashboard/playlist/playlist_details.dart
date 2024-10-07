import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:music_app/common/login_user.dart';
import 'package:music_app/common/util.dart';
import 'package:music_app/constant/import.dart';
import 'package:music_app/cubit/dashboard/playing_song/playing_song_cubit.dart';
import 'package:music_app/cubit/playlist/playlist_details_cubit.dart';
import 'package:music_app/entities/albums/mdl_album_details.dart';
import 'package:music_app/entities/playList/mdl_play_list_screen.dart';
import 'package:music_app/ui/dashboard/albums/song_list.dart';
import 'package:music_app/ui/dashboard/artist_list.dart';

class PlaylistDetails extends StatefulWidget {
  final PlaylistDetailsCubit playlistDetailsCubit;

  const PlaylistDetails({super.key, required this.playlistDetailsCubit});

  @override
  State<PlaylistDetails> createState() => _PlaylistDetailsState();
}

class _PlaylistDetailsState extends State<PlaylistDetails> {
  String playListName = '';
  bool isPlaying = false;
  late MDlPlayListResponse mDlPlayListResponse;

  @override
  void initState() {
    if (Get.arguments is MdlPlayListDetailsScreen) {
      var mdlPlayListDetails = Get.arguments as MdlPlayListDetailsScreen;
      playListName = mdlPlayListDetails.playListName ?? '';
      widget.playlistDetailsCubit
          .getPlayList(playListId: mdlPlayListDetails.playListId ?? 0);
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
        return BlocConsumer<PlaylistDetailsCubit, PlaylistDetailsState>(
          bloc: widget.playlistDetailsCubit,
          listener: (context, state) {
            if (state is PlaylistDetailsSuccessState) {
              mDlPlayListResponse = state.mDlPlayListResponse;
            }
          },
          builder: (context, state) {
            return Scaffold(
              appBar: baseAppBar(
                title: playListName ?? '',
                leading: const BackButton(),
              ),
              body: state is PlaylistDetailsLoadingState
                  ? Container(
                      height: Get.height,
                      decoration: BoxDecoration(
                        gradient: screenBackGroundColor(),
                      ),
                      child: const Center(
                        child: CircularProgressIndicator(),
                      ),
                    )
                  : state is PlaylistDetailsSuccessState
                      ? Container(
                          height: Get.height,
                          decoration: BoxDecoration(
                            gradient: screenBackGroundColor(),
                          ),
                          child: SingleChildScrollView(
                            child: mDlPlayListResponse
                                        .data?.songs?.isNotEmpty ??
                                    false
                                ? Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.center,
                                    children: [
                                      albumDetailsHeader(),
                                      albumPlaySection(
                                          songs:
                                              mDlPlayListResponse.data?.songs),
                                      SongList(
                                        songs:
                                            mDlPlayListResponse.data?.songs ??
                                                [],
                                        onTap: (value) {
                                          LoginUser.instance.playingSong.value =
                                              MDlPlayingSongs(
                                                  songs: mDlPlayListResponse
                                                          .data?.songs ??
                                                      [],
                                                  currentPlayingIndex: value);
                                          LoginUser
                                                  .instance.currentPlayAlbumId =
                                              mDlPlayListResponse.data?.id;
                                        },
                                      ),
                                      ArtistList(artistList: mDlPlayListResponse.data?.artists ?? [],),
                                      SizedBox(
                                        height: 70.h,
                                      ),
                                    ],
                                  )
                                : const Center(child: Text("No Data Found")),
                          ),
                        )
                      : Container(
                          height: Get.height,
                          width: Get.width,
                          decoration: BoxDecoration(
                            gradient: screenBackGroundColor(),
                          ),
                        ),
            );
          },
        );
      },
    );
  }

  Widget albumDetailsHeader() {
    return Padding(
      padding: EdgeInsets.all(10.w),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Expanded(
                child: Padding(
                  padding: EdgeInsets.symmetric(horizontal: 30.w),
                  child: Container(
                    clipBehavior: Clip.hardEdge,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(20.r),
                      boxShadow: const [
                        BoxShadow(
                          color: Colors.black38,
                          blurRadius: 10,
                        )
                      ],
                    ),
                    child: CachedNetworkImage(
                      imageUrl:
                          mDlPlayListResponse.data?.image?.isNotEmpty ?? false
                              ? mDlPlayListResponse.data?.image?.last.url ?? ''
                              : '',
                      errorWidget: (context, url, error) =>
                          const Icon(Icons.error),
                    ),
                  ),
                ),
              ),
            ],
          ),
          SizedBox(
            height: 10.h,
          ),
          // Text(
          //   mdlAlbumDetailsData?.data?.name ?? '',
          //   style: AppFontStyle.h3SemiBold,
          //   maxLines: 1,
          // ),
          // SizedBox(
          //   height: 5.h,
          // ),
          Text(mDlPlayListResponse.data?.description ?? '')
        ],
      ),
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
                onTap: () {},
                child: const Icon(Icons.favorite_border),
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
                            mDlPlayListResponse.data?.id) {
                      LoginUser.instance.player.pause();
                      LoginUser.instance.songPlay.value = false;
                    } else {
                      LoginUser.instance.player.play();
                      LoginUser.instance.songPlay.value = true;
                      if (LoginUser.instance.currentPlayAlbumId !=
                          mDlPlayListResponse.data?.id) {
                        LoginUser.instance.playingSong.value = MDlPlayingSongs(
                            songs: songs ?? [], currentPlayingIndex: 0);
                        LoginUser.instance.currentPlayAlbumId =
                            mDlPlayListResponse.data?.id;
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
                              mDlPlayListResponse.data?.id &&
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
