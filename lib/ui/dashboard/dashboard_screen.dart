import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:music_app/common/util.dart';
import 'package:music_app/constant/import.dart';
import 'package:music_app/cubit/dashboard/dashboard_cubit.dart';
import 'package:music_app/cubit/dashboard/favorites_sections/favorites_sections_cubit.dart';
import 'package:music_app/cubit/dashboard/recommended/recommended_section_cubit.dart';
import 'package:music_app/entities/albums/mdl_album_details_screen.dart';
import 'package:music_app/entities/albums/mdl_search_album_response.dart';
import 'package:music_app/repository/contract_builder/app_repository_builder.dart';
import 'package:music_app/ui/dashboard/favorite_sections.dart';
import 'package:music_app/ui/dashboard/recommended_sections.dart';

class DashboardScreen extends StatefulWidget {
  final DashboardCubit dashboardCubit;

  const DashboardScreen({super.key, required this.dashboardCubit});

  @override
  State<DashboardScreen> createState() => _DashboardScreenState();
}

class _DashboardScreenState extends State<DashboardScreen> {
  late List<MDLAlbumsListResults> mdlAlbumsListResults;

  @override
  void initState() {
    widget.dashboardCubit.albumsList();
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
          },
          builder: (context, state) {
            return Scaffold(
              appBar: baseAppBar(
                title: "Dashboard",
              ),
              body: state is DashboardSuccessState
                  ? Container(
                      height: Get.height,
                      padding: EdgeInsets.symmetric(horizontal: 15.w),
                      decoration: BoxDecoration(
                        gradient: screenBackGroundColor(),
                      ),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.start,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          FavoriteSections(
                            themeState: themeState,
                            favoritesSectionsCubit: FavoritesSectionsCubit(),
                          ),
                          RecommendedSections(
                            themeState: themeState,
                            recommendedSectionCubit: RecommendedSectionCubit(
                              repository: AppRepositoryBuilder.repository(
                                  of: RepositoryProviderType.home),
                            ),
                          ),
                          albumList(),
                        ],
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

  Widget albumList() {
    return Column(
      mainAxisAlignment: MainAxisAlignment.start,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: EdgeInsets.symmetric(horizontal: 10.w),
          child: Text(
            "Albums",
            style: AppFontStyle.h2Bold,
          ),
        ),
        SizedBox(
          height: 200.h,
          child: ListView.builder(
            scrollDirection: Axis.horizontal,
            itemCount: mdlAlbumsListResults.length,
            itemBuilder: (BuildContext context, int index) {
              return Padding(
                padding: const EdgeInsets.all(8.0),
                child: InkWell(
                  onTap: () {
                    Get.toNamed(
                      AppPages.albumDetails,
                      arguments: MdlAlbumDetailsScreen(
                          albumId: int.tryParse(
                            mdlAlbumsListResults[index].id ?? '',
                          ),
                          albumName: mdlAlbumsListResults[index].name),
                    );
                  },
                  child: Column(
                    children: [
                      Image.network(
                        mdlAlbumsListResults[index].image?[1].url ?? '',
                      ),
                      SizedBox(
                        width: 150.w,
                        child: Text(
                          mdlAlbumsListResults[index].name ?? '',
                          maxLines: 1,
                          overflow: TextOverflow.ellipsis,
                          textAlign: TextAlign.center,
                        ),
                      ),
                    ],
                  ),
                ),
              );
            },
          ),
        ),
      ],
    );
  }
}
