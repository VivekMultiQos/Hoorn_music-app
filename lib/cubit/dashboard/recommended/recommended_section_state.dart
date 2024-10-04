part of 'recommended_section_cubit.dart';

@immutable
sealed class RecommendedSectionState {}

final class RecommendedSectionInitial extends RecommendedSectionState {}

class RecommendedLoadingState extends RecommendedSectionState {}

class RecommendedSuccessState extends RecommendedSectionState {
  final List<Songs> songs;

  RecommendedSuccessState(this.songs);
}

class RecommendedErrorState extends RecommendedSectionState {
  final String errorMessage;

  RecommendedErrorState(this.errorMessage);
}
