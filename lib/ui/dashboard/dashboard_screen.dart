import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:music_app/common/util.dart';
import 'package:music_app/constant/import.dart';
import 'package:music_app/cubit/dashboard/dashboard_cubit.dart';
import 'package:music_app/cubit/dashboard/favorites_sections/favorites_sections_cubit.dart';
import 'package:music_app/cubit/dashboard/recommended/recommended_section_cubit.dart';
import 'package:music_app/entities/albums/mdl_album_details.dart';
import 'package:music_app/entities/albums/mdl_album_details_screen.dart';
import 'package:music_app/entities/albums/mdl_search_album_response.dart';
import 'package:music_app/repository/contract_builder/app_repository_builder.dart';
import 'package:music_app/ui/dashboard/album_list.dart';
import 'package:music_app/ui/dashboard/favorite_sections.dart';
import 'package:music_app/ui/dashboard/playlist_list.dart';
import 'package:music_app/ui/dashboard/recommended_sections.dart';

class DashboardScreen extends StatefulWidget {
  final DashboardCubit dashboardCubit;

  const DashboardScreen({super.key, required this.dashboardCubit});

  @override
  State<DashboardScreen> createState() => _DashboardScreenState();
}

class _DashboardScreenState extends State<DashboardScreen> {
  late List<MDLAlbumsListResults> mdlAlbumsListResults;
  late List<MDLPlayListResults> mdlPlayListResults;

  @override
  void initState() {
    widget.dashboardCubit.albumsList();
    widget.dashboardCubit.playListList();
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
        return BlocConsumer<DashboardCubit, DashboardState>(
          bloc: widget.dashboardCubit,
          listener: (context, state) {
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
          },
          builder: (context, state) {
            return Scaffold(
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
                body: SingleChildScrollView(
                  child: Container(
                    constraints: BoxConstraints(
                      minHeight: Get.height,
                    ),
                    padding: EdgeInsets.symmetric(horizontal: 15.w),
                    decoration: BoxDecoration(
                      gradient: screenBackGroundColor(),
                    ),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.start,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisSize: MainAxisSize.max,
                      children: [
                        FavoriteSections(
                          themeState: themeState,
                          favoritesSectionsCubit: FavoritesSectionsCubit(),
                        ),
                        const RecommendedSections(),
                        state is DashboardSuccessState
                            ? AlbumList(albumList: mdlAlbumsListResults)
                            : SizedBox(
                                height: 200.h,
                                child: const Center(
                                  child: SingleChildScrollView(),
                                ),
                              ),
                        state is DashboardPlayListSuccessState
                            ? PlayListList(
                                playListList: mdlPlayListResults,
                              )
                            : const SizedBox.shrink(),
                        SizedBox(
                          height: 70.h,
                        )
                      ],
                    ),
                  ),
                ));
          },
        );
      },
    );
  }
}
