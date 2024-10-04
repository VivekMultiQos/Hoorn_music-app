import 'package:music_app/app.dart';
import 'package:music_app/constant/import.dart';
import 'package:music_app/cubit/dashboard/albums_details/album_details_cubit.dart';
import 'package:music_app/cubit/dashboard/dashboard_cubit.dart';
import 'package:music_app/cubit/dashboard/play_screen/play_screen_cubit.dart';
import 'package:music_app/ui/dashboard/albums/album_details_screen.dart';
import 'package:music_app/ui/dashboard/dashboard_screen.dart';
import 'package:music_app/ui/dashboard/play_screen.dart';
import 'package:music_app/ui/lrf/login_page.dart';

import '../repository/contract_builder/app_repository_builder.dart';

class MainAppPages {
  static final routes = [
    GetPage(
      name: AppPages.appPage,
      page: () => const App(),
    ),
    GetPage(
      name: AppPages.loginPage,
      page: () => const LoginPage(),
    ),
    GetPage(
      name: AppPages.dashboard,
      page: () => DashboardScreen(
        dashboardCubit: DashboardCubit(
          repository:
              AppRepositoryBuilder.repository(of: RepositoryProviderType.home),
        ),
      ),
    ),
    GetPage(
      name: AppPages.albumDetails,
      page: () => AlbumDetailsScreen(
        albumDetailsCubit: AlbumDetailsCubit(
          repository:
              AppRepositoryBuilder.repository(of: RepositoryProviderType.home),
        ),
      ),
    ),
    GetPage(
      name: AppPages.playScreen,
      transition: Transition.downToUp,
      page: () => PlayScreen(
        playScreenCubit: PlayScreenCubit(),
      ),
    ),
  ];
}
