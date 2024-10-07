part of 'dashboard_cubit.dart';

@immutable
sealed class DashboardState {}

final class DashboardInitial extends DashboardState {}

class DashboardLoadingState extends DashboardState {}

class DashboardSuccessState extends DashboardState {
  final MdlSearchAlbumResponse mdlSearchAlbumResponse;

  DashboardSuccessState(this.mdlSearchAlbumResponse);
}

class DashboardPlayListSuccessState extends DashboardState {
  final MDLSearchPlayListResponse mdlSearchPlayListResponse;

  DashboardPlayListSuccessState(this.mdlSearchPlayListResponse);
}


class DashboardArtistSuccessState extends DashboardState {
  final MDlSearchArtistResponse mDlSearchArtistResponse;

  DashboardArtistSuccessState(this.mDlSearchArtistResponse);
}

class DashboardErrorState extends DashboardState {
  final String errorMessage;

  DashboardErrorState(this.errorMessage);
}
