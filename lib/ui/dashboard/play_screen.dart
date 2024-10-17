import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_html/flutter_html.dart';
import 'package:just_audio/just_audio.dart';
import 'package:music_app/common/login_user.dart';
import 'package:music_app/common/util.dart';
import 'package:music_app/constant/import.dart';
import 'package:music_app/cubit/dashboard/play_screen/play_screen_cubit.dart';
import 'package:music_app/entities/albums/mdl_album_details.dart';
import 'package:music_app/entities/dashboard/mdl_play_screen.dart';
import 'package:music_app/ui/common/sound_bottom_sheet.dart';
import 'package:text_scroll/text_scroll.dart';

class PlayScreen extends StatefulWidget {
  final PlayScreenCubit playScreenCubit;

  const PlayScreen({super.key, required this.playScreenCubit});

  @override
  State<PlayScreen> createState() => _PlayScreenState();
}

class _PlayScreenState extends State<PlayScreen> {
  late MdlPlayScreen mdlPlaySong;
  late Songs currentSong;
  bool showLyrics = false;

  String lyrics = "";

  @override
  void initState() {
    if (Get.arguments is MdlPlayScreen) {
      mdlPlaySong = Get.arguments as MdlPlayScreen;
      currentSong = mdlPlaySong.songs;
    }
    var callBack = mdlPlaySong.hidePlayingWidget;
    if (callBack != null) {
      callBack(true);
    }

    LoginUser.instance.currentPlayingSong.listen((value) {
      currentSong = value;
      showLyrics = false;
      lyrics = '';
      setState(() {});
    });

    super.initState();
  }

  @override
  void dispose() {
    hideLoader();
    var callBack = mdlPlaySong.hidePlayingWidget;
    if (callBack != null) {
      callBack(false);
    }
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<ThemeCubit, ChangeThemeState>(
      bloc: changeThemeCubit,
      builder: (context, themeState) {
        return BlocConsumer<PlayScreenCubit, PlayScreenState>(
          bloc: widget.playScreenCubit,
          listener: (context, state) {
            if (state is PlayScreenSuccessState) {
              lyrics = state.lyrics;
            }
          },
          builder: (context, state) {
            return Scaffold(
              appBar: baseAppBar(
                  leading: InkWell(
                    onTap: () {
                      Get.back();
                    },
                    child: Icon(
                      Icons.keyboard_arrow_down_outlined,
                      size: 40.w,
                    ),
                  ),
                  widgets: [
                    InkWell(
                      onTap: () {
                        setState(() {
                          showLyrics = !showLyrics;
                        });
                        if (showLyrics) {
                          widget.playScreenCubit
                              .getLyrics(songId: currentSong.id ?? '');
                        }
                      },
                      child: Icon(
                        Icons.short_text_rounded,
                        size: 30.w,
                      ),
                    ),
                    SizedBox(
                      width: 20.w,
                    ),
                    InkWell(
                      onTap: () {
                        Get.bottomSheet(
                          SoundBottomSheet(
                            themeState: themeState,
                          ),
                        );
                      },
                      child: Icon(
                        Icons.more_vert,
                        size: 30.w,
                      ),
                    ),
                    SizedBox(
                      width: 20.w,
                    )
                  ]),
              body: Container(
                height: Get.height,
                width: Get.width,
                decoration: BoxDecoration(
                  gradient: screenBackGroundColor(),
                ),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        showLyrics
                            ? SizedBox(
                                height: 500.h,
                                width: Get.width,
                                child: Center(
                                  child: state is PlayScreenLoadingState
                                      ? const CircularProgressIndicator()
                                      : state is PlayScreenErrorState
                                          ? const Text("Lyrics not found")
                                          : SingleChildScrollView(
                                              child: Padding(
                                                padding: EdgeInsets.symmetric(
                                                    horizontal: 20.w,
                                                    vertical: 10.h),
                                                child: Html(
                                                  data: lyrics,
                                                  // Pass your lyrics string with <br> tags
                                                  style: {
                                                    "body": Style(
                                                      fontSize:
                                                          FontSize(16.0),
                                                      color: Colors.black,
                                                      textAlign:
                                                          TextAlign.center,
                                                    ),
                                                  },
                                                ),
                                              ),
                                            ),
                                ),
                              )
                            : Expanded(
                                child: Padding(
                                  padding: EdgeInsets.all(50.w),
                                  child: Container(
                                    clipBehavior: Clip.hardEdge,
                                    decoration: BoxDecoration(
                                      borderRadius:
                                          BorderRadius.circular(20.r),
                                      boxShadow: const [
                                        BoxShadow(
                                          color: Colors.black38,
                                          blurRadius: 10,
                                        )
                                      ],
                                    ),
                                    child: CachedNetworkImage(
                                      imageUrl: currentSong
                                                  .image?.isNotEmpty ??
                                              false
                                          ? currentSong.image?.last.url ?? ''
                                          : '',
                                      errorWidget: (context, url, error) =>
                                          const Icon(Icons.error),
                                    ),
                                  ),
                                ),
                              ),
                      ],
                    ),
                    Column(
                      children: [
                        TextScroll(
                          currentSong.name ?? 'Title',
                          style: AppFontStyle.h1Bold,
                          mode: TextScrollMode.endless,
                        ),
                        TextScroll(
                          currentSong.artists?.primary?.first.name ??
                              'artist',
                          style: AppFontStyle.h3Regular,
                          mode: TextScrollMode.endless,
                        ),
                        SizedBox(
                          height: 50.h,
                        ),
                        Column(
                          children: [
                            StreamBuilder<Duration>(
                              stream:
                                  LoginUser.instance.player.positionStream,
                              builder: (context, snapshot) {
                                final position =
                                    snapshot.data ?? Duration.zero;
                                final totalDuration =
                                    LoginUser.instance.player.duration ??
                                        Duration.zero;
                                return Column(
                                  children: [
                                    Slider(
                                      value: position.inSeconds.toDouble(),
                                      max: totalDuration.inSeconds.toDouble(),
                                      activeColor: Colors.black,
                                      inactiveColor: Colors.grey,
                                      onChanged: (double value) async {
                                        // Seek to the position when the slider is moved
                                        await LoginUser.instance.player.seek(
                                            Duration(seconds: value.toInt()));
                                      },
                                    ),
                                    Padding(
                                      padding: EdgeInsets.symmetric(
                                          horizontal: 25.w),
                                      child: Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.spaceBetween,
                                        children: [
                                          // Display current playing time
                                          Text(
                                            formatDuration(position),
                                            style: const TextStyle(
                                                color: Colors.black),
                                          ),
                                          // Display total song duration
                                          Text(
                                            formatDuration(totalDuration),
                                            style: const TextStyle(
                                                color: Colors.black),
                                          ),
                                        ],
                                      ),
                                    ),
                                  ],
                                );
                              },
                            ),
                          ],
                        ),
                        playRow(),
                      ],
                    ),
                  ],
                ),
              ),
            );
          },
        );
      },
    );
  }

  Widget playRow() {
    return Padding(
      padding: EdgeInsets.all(25.w),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          InkWell(
            onTap: () {
              addFavoriteSong(currentSong);
              setState(() {});
            },
            child: Icon(
              LoginUser.instance.favoriteSong
                      .any((song) => song.id == currentSong.id)
                  ? Icons.favorite
                  : Icons.favorite_border,
              size: 30.w,
              color: LoginUser.instance.favoriteSong
                      .any((song) => song.id == currentSong.id)
                  ? Colors.green
                  : Colors.black,
            ),
          ),
          InkWell(
            onTap: () {
              var callBack = mdlPlaySong.previous;
              if (callBack != null) {
                callBack("previous");
              }
            },
            child: Icon(
              Icons.skip_previous,
              size: 30.w,
            ),
          ),
          InkWell(
            onTap: () {
              setState(() {
                if (LoginUser.instance.player.playing) {
                  LoginUser.instance.player.pause();
                  LoginUser.instance.songPlay.value = false;
                } else {
                  LoginUser.instance.player.play();
                  LoginUser.instance.songPlay.value = true;
                }
              });
            },
            child: Container(
              padding: EdgeInsets.all(8.w),
              decoration: BoxDecoration(
                color: Colors.grey,
                shape: BoxShape.rectangle,
                borderRadius: BorderRadius.circular(10.r),
              ),
              child: Icon(
                LoginUser.instance.player.playing
                    ? Icons.pause
                    : Icons.play_arrow,
                size: 40.w,
              ),
            ),
          ),
          InkWell(
            onTap: () {
              var callBack = mdlPlaySong.next;
              if (callBack != null) {
                callBack("next");
              }
            },
            child: Icon(
              Icons.skip_next,
              size: 30.w,
            ),
          ),
          InkWell(
            onTap: () {
              if (LoginUser.instance.playInLoop.value == LoopMode.off) {
                LoginUser.instance.playInLoop.value = LoopMode.all;
              } else {
                LoginUser.instance.playInLoop.value = LoopMode.off;
              }
              setState(() {});
            },
            child: Icon(
              Icons.repeat,
              size: 30.w,
              color: LoginUser.instance.playInLoop.value != LoopMode.off
                  ? Colors.green
                  : Colors.black,
            ),
          ),
        ],
      ),
    );
  }
}
