import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:music_app/cubit/prefetch/prefetch_state.dart';

import 'package:music_app/repository/contract_builder/app_repository_contract.dart';

class PrefetchCubit extends Cubit<PrefetchState> {
  AppRepositoryContract repository;

  PrefetchCubit({
    required this.repository,
  }) : super(PrefetchInitialState());

  void getDropDownList() async {
    emit(PrefetchLoadingState(message: 'getDropDownList'));
    Future.delayed(const Duration(milliseconds: 2000), () {
      emit(PrefetchDropDownSuccessState());
    });
  }
}
