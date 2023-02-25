import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';

part 'room_state.dart';

class RoomCubit extends Cubit<RoomState> {
  RoomCubit() : super(RoomInitial());
}
