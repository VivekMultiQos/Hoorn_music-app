import 'dart:math';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:music_app/common/login_user.dart';
import 'package:music_app/common/util.dart';
import 'package:music_app/constant/import.dart';
import 'package:music_app/cubit/dashboard/dashboard_cubit.dart';
import 'package:music_app/cubit/dashboard/favorites_sections/favorites_sections_cubit.dart';
import 'package:music_app/entities/albums/mdl_album_details.dart';
import 'package:music_app/entities/albums/mdl_search_album_response.dart';
import 'package:music_app/ui/dashboard/album_list.dart';
import 'package:music_app/ui/dashboard/artist_list.dart';
import 'package:music_app/ui/dashboard/favorite_sections.dart';
import 'package:music_app/ui/dashboard/playlist_list.dart';
import 'package:music_app/ui/dashboard/recommended_sections.dart';
import 'package:pull_to_refresh_flutter3/pull_to_refresh_flutter3.dart';

class DashboardScreen extends StatefulWidget {
  final DashboardCubit dashboardCubit;

  const DashboardScreen({super.key, required this.dashboardCubit});

  @override
  State<DashboardScreen> createState() => _DashboardScreenState();
}

class _DashboardScreenState extends State<DashboardScreen> {
  final RefreshController _refreshController =
      RefreshController(initialRefresh: false);
  List<MDLAlbumsListResults> mdlAlbumsListResults = [];
  List<MDLPlayListResults> mdlPlayListResults = [];
  List<PlayListArtists> mdlArtistResult = [];

  void initState() {
    super.initState();

    if (LoginUser.instance.preferSinger.isNotEmpty) {
      widget.dashboardCubit.albumsList(searchText: getRandomSinger());
      widget.dashboardCubit.playListList(searchText: getRandomSinger());
      widget.dashboardCubit.searchArtists(searchText: getRandomSinger());
    }
  }

  String getRandomSinger() {
    var randomIndex = Random().nextInt(LoginUser.instance.preferSinger.length);
    var randomSinger = LoginUser.instance.preferSinger[randomIndex].name;
    return randomSinger;
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
        return BlocConsumer<DashboardCubit, DashboardState>(
          bloc: widget.dashboardCubit,
          listener: (context, state) {
            _refreshController.refreshCompleted();
            if (state is DashboardLoadingState) {
              showLoader(context);
            } else if (state is DashboardSuccessState) {
              mdlAlbumsListResults =
                  state.mdlSearchAlbumResponse.data?.results ?? [];
              hideLoader();
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
            return Container(
              decoration: BoxDecoration(
                gradient: screenBackGroundColor(),
              ),
              child: Scaffold(
                backgroundColor: Colors.transparent,
                appBar: baseAppBar(
                  title: "Dashboard",
                  titleStyle: AppFontStyle.h1Bold,
                  widgets: [
                    InkWell(
                      onTap: () {
                        Get.toNamed(AppPages.search);
                      },
                      child: Icon(
                        Icons.search,
                        color: Colors.black,
                        size: 30.w,
                      ),
                    ),
                    SizedBox(
                      width: 15.w,
                    )
                  ],
                ),
                body: SmartRefresher(
                  controller: _refreshController,
                  physics: const BouncingScrollPhysics(),
                  enablePullDown: true,
                  enablePullUp: false,
                  onRefresh: _onRefresh,
                  header: WaterDropHeader(
                    complete: Container(),
                    waterDropColor: Colors.black,
                  ),
                  child: SingleChildScrollView(
                    child: Container(
                      constraints: BoxConstraints(
                        minHeight: Get.height,
                      ),
                      decoration: BoxDecoration(
                        gradient: screenBackGroundColor(),
                      ),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.start,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        mainAxisSize: MainAxisSize.max,
                        children: [
                          LoginUser.instance.favoriteSong.isNotEmpty
                              ? FavoriteSections(
                                  themeState: themeState,
                                  favoritesSectionsCubit:
                                      FavoritesSectionsCubit(),
                                )
                              : const SizedBox.shrink(),
                          const RecommendedSections(songID: "yDeAS8Eh"),
                          mdlAlbumsListResults.isNotEmpty
                              ? AlbumList(albumList: mdlAlbumsListResults)
                              : SizedBox(
                                  height: 200.h,
                                  child: const Center(
                                    child: SingleChildScrollView(),
                                  ),
                                ),
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
                ),
              ),
            );
          },
        );
      },
    );
  }

  void _onRefresh() async {
    if (LoginUser.instance.preferSinger.isNotEmpty) {
      widget.dashboardCubit.albumsList(searchText: getRandomSinger());
      widget.dashboardCubit.playListList(searchText: getRandomSinger());
      widget.dashboardCubit.searchArtists(searchText: getRandomSinger());
    }
    LoginUser.instance.updateRecommended.value = true;
  }
}
