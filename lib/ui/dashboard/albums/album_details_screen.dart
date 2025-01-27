import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:music_app/common/login_user.dart';
import 'package:music_app/common/util.dart';
import 'package:music_app/constant/import.dart';
import 'package:music_app/cubit/dashboard/albums_details/album_details_cubit.dart';
import 'package:music_app/cubit/dashboard/playing_song/playing_song_cubit.dart';
import 'package:music_app/entities/albums/mdl_album_details.dart';
import 'package:music_app/entities/albums/mdl_album_details_screen.dart';
import 'package:music_app/entities/albums/mdl_local_store.dart';
import 'package:music_app/ui/dashboard/albums/song_list.dart';
import 'package:music_app/ui/dashboard/song_tail.dart';

class AlbumDetailsScreen extends StatefulWidget {
  final AlbumDetailsCubit albumDetailsCubit;

  const AlbumDetailsScreen({super.key, required this.albumDetailsCubit});

  @override
  State<AlbumDetailsScreen> createState() => _AlbumDetailsScreenState();
}

class _AlbumDetailsScreenState extends State<AlbumDetailsScreen> {
  String? albumName;
  MdlAlbumDetails? mdlAlbumDetailsData;
  bool isPlaying = false;

  @override
  void initState() {
    if (Get.arguments is MdlAlbumDetailsScreen) {
      var mdlAlbumDetails = Get.arguments as MdlAlbumDetailsScreen;
      albumName = mdlAlbumDetails.albumName;
      widget.albumDetailsCubit.getAlbums(albumId: mdlAlbumDetails.albumId ?? 0);
    }

    LoginUser.instance.songPlay.listen((value) {
      isPlaying = value;
      setState(() {});
    });
    super.initState();
  }

  @override
  void dispose() {
    hideLoader();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<ThemeCubit, ChangeThemeState>(
      bloc: changeThemeCubit,
      builder: (context, themeState) {
        return BlocConsumer<AlbumDetailsCubit, AlbumDetailsState>(
          bloc: widget.albumDetailsCubit,
          listener: (context, state) {
            if (state is AlbumDetailsSuccessState) {
              hideLoader();
              mdlAlbumDetailsData = state.mdlAlbumDetails;
            }
          },
          builder: (context, state) {
            return Scaffold(
              appBar: baseAppBar(
                title: albumName ?? '',
                leading: const BackButton(),
              ),
              body: state is AlbumDetailsLoadingState
                  ? Container(
                      height: Get.height,
                      decoration: BoxDecoration(
                        gradient: screenBackGroundColor(),
                      ),
                      child: const Center(
                        child: CircularProgressIndicator(),
                      ),
                    )
                  : state is AlbumDetailsSuccessState
                      ? Container(
                          height: Get.height,
                          decoration: BoxDecoration(
                            gradient: screenBackGroundColor(),
                          ),
                          child: SingleChildScrollView(
                            child: mdlAlbumDetailsData
                                        ?.data?.songs?.isNotEmpty ??
                                    false
                                ? Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.center,
                                    children: [
                                      albumDetailsHeader(),
                                      albumPlaySection(
                                          songs:
                                              mdlAlbumDetailsData?.data?.songs),
                                      SongList(
                                        songs:
                                            mdlAlbumDetailsData?.data?.songs ??
                                                [],
                                        onTap: (value) {
                                          LoginUser.instance.playingSong.value =
                                              MDlPlayingSongs(
                                                  songs: mdlAlbumDetailsData
                                                          ?.data?.songs ??
                                                      [],
                                                  currentPlayingIndex: value);
                                          LoginUser
                                                  .instance.currentPlayAlbumId =
                                              mdlAlbumDetailsData?.data?.id;
                                        },
                                      ),
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
                          mdlAlbumDetailsData?.data?.image?.isNotEmpty ?? false
                              ? mdlAlbumDetailsData?.data?.image?.last.url ?? ''
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
          Text(mdlAlbumDetailsData?.data?.description ?? '')
        ],
      ),
    );
  }

  Widget albumPlaySection({List<Songs>? songs}) {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 10.w),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.end,
        children: [
          InkWell(
            onTap: () {
              setState(() {
                if (LoginUser.instance.player.playing &&
                    LoginUser.instance.currentPlayAlbumId ==
                        mdlAlbumDetailsData?.data?.id) {
                  LoginUser.instance.player.pause();
                  LoginUser.instance.songPlay.value = false;
                } else {
                  LoginUser.instance.player.play();
                  LoginUser.instance.songPlay.value = true;
                  if (LoginUser.instance.currentPlayAlbumId !=
                      mdlAlbumDetailsData?.data?.id) {
                    LoginUser.instance.playingSong.value = MDlPlayingSongs(
                        songs: songs ?? [], currentPlayingIndex: 0);
                    LoginUser.instance.currentPlayAlbumId =
                        mdlAlbumDetailsData?.data?.id;
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
                          mdlAlbumDetailsData?.data?.id &&
                      isPlaying
                  ? Icons.pause
                  : Icons.play_arrow),
            ),
          )
        ],
      ),
    );
  }
}
