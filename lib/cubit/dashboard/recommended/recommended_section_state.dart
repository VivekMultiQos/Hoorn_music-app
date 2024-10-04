part of 'recommended_section_cubit.dart';

@immutable
sealed class RecommendedSectionState {}

final class RecommendedSectionInitial extends RecommendedSectionState {}

final class RecommendedLoadingState extends RecommendedSectionState {}

final class RecommendedSuccessState extends RecommendedSectionState {}

class RecommendedErrorState extends RecommendedSectionState {
  final String errorMessage;

  RecommendedErrorState(this.errorMessage);
}
