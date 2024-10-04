import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';

part 'play_screen_state.dart';

class PlayScreenCubit extends Cubit<PlayScreenState> {
  PlayScreenCubit() : super(PlayScreenInitial());
}
