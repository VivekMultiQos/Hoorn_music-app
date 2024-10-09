import 'package:music_app/app.dart';
import 'package:music_app/constant/import.dart';
import 'package:music_app/cubit/artists/artist_details_cubit.dart';
import 'package:music_app/cubit/dashboard/albums_details/album_details_cubit.dart';
import 'package:music_app/cubit/dashboard/dashboard_cubit.dart';
import 'package:music_app/cubit/dashboard/play_screen/play_screen_cubit.dart';
import 'package:music_app/cubit/dashboard/search/search_cubit.dart';
import 'package:music_app/cubit/playlist/playlist_details_cubit.dart';
import 'package:music_app/cubit/prefetch/prefetch_cubit.dart';
import 'package:music_app/prefetch/prefetch_page.dart';
import 'package:music_app/ui/dashboard/albums/album_details_screen.dart';
import 'package:music_app/ui/dashboard/artist/artist_details_screen.dart';
import 'package:music_app/ui/dashboard/dashboard_screen.dart';
import 'package:music_app/ui/dashboard/play_screen.dart';
import 'package:music_app/ui/dashboard/playlist/playlist_details.dart';
import 'package:music_app/ui/dashboard/search.dart';
import 'package:music_app/ui/lrf/login_page.dart';
import 'package:music_app/ui/prefere_screen.dart';
import 'package:music_app/ui/welcome_screen.dart';

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
      name: AppPages.welcomeScreen,
      page: () => const WelcomeScreen(),
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
        playScreenCubit: PlayScreenCubit(
            repository: AppRepositoryBuilder.repository(
                of: RepositoryProviderType.home)),
      ),
    ),
    GetPage(
      name: AppPages.search,
      transition: Transition.rightToLeft,
      page: () => SearchScreen(
        searchCubit: SearchCubit(
            repository: AppRepositoryBuilder.repository(
                of: RepositoryProviderType.home)),
      ),
    ),
    GetPage(
      name: AppPages.playListDetails,
      transition: Transition.rightToLeft,
      page: () => PlaylistDetails(
        playlistDetailsCubit: PlaylistDetailsCubit(
            repository: AppRepositoryBuilder.repository(
                of: RepositoryProviderType.home)),
      ),
    ),
    GetPage(
      name: AppPages.artistDetails,
      transition: Transition.rightToLeft,
      page: () => ArtistDetailsScreen(
        artistDetailsCubit: ArtistDetailsCubit(
            repository: AppRepositoryBuilder.repository(
                of: RepositoryProviderType.home)),
      ),
    ),
    GetPage(
      name: AppPages.prefetchPage,
      transition: Transition.rightToLeft,
      page: () => PrefetchPage(
        prefetchCubit: PrefetchCubit(
            repository: AppRepositoryBuilder.repository(
                of: RepositoryProviderType.home)),
      ),
    ),
    GetPage(
      name: AppPages.preferScreen,
      transition: Transition.rightToLeft,
      page: () => const PreferScreen(),
    ),
  ];
}
