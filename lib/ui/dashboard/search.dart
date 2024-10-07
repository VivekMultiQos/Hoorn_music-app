import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:music_app/common/login_user.dart';
import 'package:music_app/common/util.dart';
import 'package:music_app/constant/import.dart';
import 'package:music_app/cubit/dashboard/playing_song/playing_song_cubit.dart';
import 'package:music_app/cubit/dashboard/search/search_cubit.dart';
import 'package:music_app/entities/albums/mdl_album_details.dart';
import 'package:music_app/entities/albums/mdl_search_album_response.dart';
import 'package:music_app/ui/common/common_textfield.dart';
import 'package:music_app/ui/dashboard/album_list.dart';
import 'package:music_app/ui/dashboard/albums/song_list.dart';
import 'package:music_app/ui/dashboard/artist_list.dart';
import 'package:music_app/ui/dashboard/playlist_list.dart';

class SearchScreen extends StatefulWidget {
  final SearchCubit searchCubit;

  const SearchScreen({super.key, required this.searchCubit});

  @override
  State<SearchScreen> createState() => _SearchScreenState();
}

class _SearchScreenState extends State<SearchScreen> {
  final TextEditingController _controller = TextEditingController();
  List<MDLAlbumsListResults> mdlAlbumsListResults = [];
  List<MDLPlayListResults> mdlPlayListResults = [];
  List<PlayListArtists> mdlArtistResult = [];
  List<Songs> songList = [];

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<ThemeCubit, ChangeThemeState>(
      bloc: changeThemeCubit,
      builder: (context, themeState) {
        return BlocConsumer<SearchCubit, SearchState>(
          bloc: widget.searchCubit,
          listener: (context, state) {
            if (state is SearchSuccessState) {
              mdlAlbumsListResults =
                  state.mdlSearchAlbumResponse.data?.results ?? [];
            }

            if (state is SearchSongSuccessState) {
              songList = state.mdlSearchAlbumResponse;
            }

            if (state is DashboardPlayListSuccessState) {
              mdlPlayListResults =
                  state.mdlSearchPlayListResponse.data?.results ?? [];
            }

            if (state is DashboardArtistSuccessState) {
              mdlArtistResult =
                  state.mDlSearchArtistResponse.data?.results ?? [];
            }
          },
          builder: (context, state) {
            return Scaffold(
              appBar: baseAppBar(
                leading: BackButton(
                  onPressed: () {
                    Get.back();
                  },
                ),
                widgets: [
                  SizedBox(
                    width: Get.width - 60.w,
                    child: Padding(
                      padding: EdgeInsets.symmetric(vertical: 8.0.w),
                      child: CustomTextField(
                        hintText: 'Search',
                        controller: _controller,
                        themeState: themeState,
                        onChange: (value) {
                          widget.searchCubit.albumsList(
                            searchText: _controller.text,
                          );
                          widget.searchCubit.songList(
                            searchText: _controller.text,
                          );

                          widget.searchCubit
                              .playListList(searchText: _controller.text);
                          widget.searchCubit
                              .searchArtists(searchText: _controller.text);
                        },
                      ),
                    ),
                  ),
                ],
              ),
              body: SingleChildScrollView(
                child: Container(
                  constraints: BoxConstraints(
                    minHeight: Get.height,
                  ),
                  decoration: BoxDecoration(
                    gradient: screenBackGroundColor(),
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      SizedBox(
                        height: 10.h,
                      ),
                      state is SearchErrorState || state is SearchLoadingState
                          ? const Center(child: CircularProgressIndicator())
                          : const SizedBox.shrink(),
                      songList.isNotEmpty
                          ? Padding(
                              padding: EdgeInsets.symmetric(horizontal: 10.w),
                              child: Text(
                                "Songs",
                                style: AppFontStyle.h2Bold,
                              ),
                            )
                          : const SizedBox.shrink(),
                      SongList(
                        songs: songList,
                        onTap: (value) {
                          LoginUser.instance.playingSong.value =
                              MDlPlayingSongs(
                            songs: songList,
                            currentPlayingIndex: value,
                          );
                        },
                      ),
                      AlbumList(albumList: mdlAlbumsListResults),
                      mdlPlayListResults.isNotEmpty
                          ? PlayListList(
                              playListList: mdlPlayListResults,
                            )
                          : const SizedBox.shrink(),
                      mdlArtistResult.isNotEmpty
                          ? ArtistList(
                              artistList: mdlArtistResult,
                            )
                          : const SizedBox.shrink(),
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
}
