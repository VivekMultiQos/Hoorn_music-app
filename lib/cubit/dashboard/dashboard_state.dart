part of 'dashboard_cubit.dart';

@immutable
sealed class DashboardState {}

final class DashboardInitial extends DashboardState {}

class DashboardLoadingState extends DashboardState {}

class DashboardSuccessState extends DashboardState {
  final MdlSearchAlbumResponse mdlSearchAlbumResponse;

  DashboardSuccessState(this.mdlSearchAlbumResponse);
}

class DashboardErrorState extends DashboardState {
  final String errorMessage;

  DashboardErrorState(this.errorMessage);
}
