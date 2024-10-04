part of 'favorites_sections_cubit.dart';

@immutable
sealed class FavoritesSectionsState {}

final class FavoritesSectionsInitial extends FavoritesSectionsState {}
final class FavoritesLoadingState extends FavoritesSectionsState {}
final class FavoritesSuccessState extends FavoritesSectionsState {}
