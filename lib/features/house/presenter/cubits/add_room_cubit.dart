import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';

part 'add_room_state.dart';

class AddRoomCubit extends Cubit<AddRoomState> {
  AddRoomCubit() : super(const AddRoomState());

  void addRoomName(String name) {
    if (name.isEmpty) {
      emit(const AddRoomState());
    } else {
      emit(AddRoomState(name: name));
    }
  }
}
