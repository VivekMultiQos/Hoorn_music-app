import 'package:audio_session/audio_session.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:just_audio/just_audio.dart';
import 'package:music_app/common/login_user.dart';
import 'package:music_app/common/util.dart';
import 'package:music_app/constant/import.dart';
import 'package:music_app/cubit/dashboard/playing_song/playing_song_cubit.dart';
import 'package:music_app/entities/albums/mdl_album_details.dart';
import 'package:music_app/entities/dashboard/mdl_play_screen.dart';
import 'package:rxdart/rxdart.dart' as rxdart;

class PlayingSongWidget extends StatefulWidget {
  final PlayingSongCubit playingSongCubit;

  const PlayingSongWidget({super.key, required this.playingSongCubit});

  @override
  State<PlayingSongWidget> createState() => _PlayingSongWidgetState();
}

class _PlayingSongWidgetState extends State<PlayingSongWidget> {
  late Songs _currentSong;
  late List<Songs> _allSong;
  late int _currentPlay;
  bool hideWidget = false;

  @override
  void initState() {
    LoginUser.instance.playingSong.listen((value) {
      _allSong = value.songs;
      _currentPlay = value.currentPlayingIndex;
      widget.playingSongCubit
          .updateSong(song: value.songs[value.currentPlayingIndex]);
    });

    LoginUser.instance.playInLoop.listen((value) {
      if (value == LoopMode.all) {
        LoginUser.instance.player.setLoopMode(LoopMode.all);
      } else {
        LoginUser.instance.player.setLoopMode(LoopMode.off);
      }
    });
    super.initState();
  }

  Future<void> _init() async {
    final session = await AudioSession.instance;
    await session.configure(const AudioSessionConfiguration.speech());

    LoginUser.instance.player.processingStateStream.listen((processingState) {
      if (processingState == ProcessingState.completed) {
        if (_currentPlay < _allSong.length - 1) {
          _playNextSong();
        }
      }
    }, onError: (Object e, StackTrace stackTrace) {
      print('A stream error occurred: $e');
    });

    try {
      await LoginUser.instance.player.setAudioSource(
        AudioSource.uri(
          Uri.parse(_currentSong.downloadUrl?.last.url ?? ''),
        ),
      );
    } on PlayerException catch (e) {
      print("Error loading audio source: $e");
    }
  }

  void _playNextSong() {
    if (_currentPlay < _allSong.length - 1) {
      setState(() {
        _currentPlay++;
        _currentSong = _allSong[_currentPlay];
      });
      widget.playingSongCubit.updateUI(song: _currentSong);
      LoginUser.instance.player.setAudioSource(
        AudioSource.uri(
          Uri.parse(_currentSong.downloadUrl?.last.url ?? ''),
        ),
      );
      LoginUser.instance.player.play();
    } else {
      print('Reached the last song in the playlist.');
    }
  }

  @override
  void dispose() {
    LoginUser.instance.player.dispose();
    hideLoader();
    super.dispose();
  }

  Stream<bool> get _isPlayingStream =>
      rxdart.Rx.combineLatest2<ProcessingState, bool, bool>(
          LoginUser.instance.player.processingStateStream,
          LoginUser.instance.player.playingStream,
          (state, playing) => playing && state != ProcessingState.completed);

  @override
  Widget build(BuildContext context) {
    return Material(
      child: BlocBuilder<ThemeCubit, ChangeThemeState>(
        bloc: changeThemeCubit,
        builder: (context, themeState) {
          return BlocConsumer<PlayingSongCubit, PlayingSongState>(
            bloc: widget.playingSongCubit,
            listener: (context, state) {
              if (state is PlayingSongSuccessState) {
                _currentSong = state.songs;
                _init();
                LoginUser.instance.player.play();
                LoginUser.instance.songPlay.value = true;
              }
            },
            builder: (context, state) {
              if (state is PlayingSongSuccessState) {
                return StreamBuilder<bool>(
                  stream: _isPlayingStream,
                  builder: (context, snapshot) {
                    bool isPlaying = snapshot.data ?? false;
                    return hideWidget == false
                        ? InkWell(
                            onTap: () {
                              Get.toNamed(
                                AppPages.playScreen,
                                arguments: MdlPlayScreen(
                                    songs: _currentSong,
                                    hidePlayingWidget: (value) {
                                      WidgetsBinding.instance
                                          .addPostFrameCallback((_) {
                                        setState(() {
                                          hideWidget = value;
                                        });
                                      });
                                    },
                                    previous: (value) {
                                      if (_currentSong.id !=
                                          _allSong.first.id) {
                                        widget.playingSongCubit.updateSong(
                                            song: _allSong[_currentPlay - 1]);
                                        _currentPlay--;
                                      } else {
                                        widget.playingSongCubit.updateSong(
                                            song: _allSong[_currentPlay]);
                                      }
                                    },
                                    next: (value) {
                                      if (_currentSong.id != _allSong.last.id) {
                                        widget.playingSongCubit.updateSong(
                                            song: _allSong[_currentPlay + 1]);
                                        _currentPlay++;
                                      } else {
                                        widget.playingSongCubit.updateSong(
                                            song: _allSong[_currentPlay]);
                                      }
                                    }),
                              );
                            },
                            child: Container(
                              padding: EdgeInsets.all(10.w),
                              height: 70,
                              width: Get.width,
                              decoration: const BoxDecoration(
                                  color: Colors.white,
                                  // borderRadius: BorderRadius.only(
                                  //   topLeft: Radius.circular(20.r),
                                  //   topRight: Radius.circular(20.r),
                                  // ),
                                  boxShadow: [
                                    BoxShadow(
                                      color: Colors.black45,
                                      blurRadius: 10,
                                    )
                                  ]),
                              child: Row(
                                children: [
                                  Container(
                                    clipBehavior: Clip.hardEdge,
                                    decoration: BoxDecoration(
                                      borderRadius: BorderRadius.circular(10.r),
                                    ),
                                    child: Image.network(
                                        _currentSong.image?[0].url ?? ''),
                                  ),
                                  SizedBox(
                                    width: 10.w,
                                  ),
                                  Expanded(
                                    child: Column(
                                      mainAxisAlignment:
                                          MainAxisAlignment.start,
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        Text(
                                          _currentSong.name ?? '',
                                          style:
                                              AppFontStyle.h2SemiBold.copyWith(
                                            color: Colors.black,
                                            decoration: TextDecoration.none,
                                          ),
                                          maxLines: 1,
                                          overflow: TextOverflow.ellipsis,
                                        ),
                                        Text(
                                          _currentSong
                                                  .artists?.primary?[0].name ??
                                              '',
                                          style:
                                              AppFontStyle.h3Regular.copyWith(
                                            color: Colors.black,
                                            decoration: TextDecoration.none,
                                          ),
                                          maxLines: 1,
                                          overflow: TextOverflow.ellipsis,
                                        ),
                                      ],
                                    ),
                                  ),
                                  if (_currentSong.id != _allSong.first.id)
                                    InkWell(
                                      onTap: () {
                                        widget.playingSongCubit.updateSong(
                                            song: _allSong[_currentPlay - 1]);
                                        _currentPlay--;
                                      },
                                      child: const Icon(
                                        Icons.skip_previous,
                                        size: 30,
                                      ),
                                    ),
                                  InkWell(
                                    onTap: () {
                                      if (isPlaying) {
                                        LoginUser.instance.player.pause();
                                        LoginUser.instance.songPlay.value =
                                            false;
                                      } else {
                                        LoginUser.instance.songPlay.value =
                                            true;
                                        LoginUser.instance.player.play();
                                      }
                                    },
                                    child: Icon(
                                      isPlaying &&
                                              LoginUser.instance.player.playing
                                          ? Icons.pause
                                          : Icons.play_arrow,
                                      size: 40,
                                    ),
                                  ),
                                  if (_currentSong.id != _allSong.last.id)
                                    InkWell(
                                      onTap: () {
                                        widget.playingSongCubit.updateSong(
                                            song: _allSong[_currentPlay + 1]);
                                        _currentPlay++;
                                      },
                                      child: const Icon(
                                        Icons.skip_next,
                                        size: 30,
                                      ),
                                    )
                                ],
                              ),
                            ),
                          )
                        : const SizedBox.shrink();
                  },
                );
              }
              return const SizedBox.shrink();
            },
          );
        },
      ),
    );
  }
}