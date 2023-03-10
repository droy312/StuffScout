import 'package:bloc/bloc.dart';
import 'package:flutter/cupertino.dart';
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

  void addRoom(BuildContext context, Future addRoom) async {
    emit(state.copyWith(isLoading: true));

    await addRoom;

    emit(state.copyWith(isLoading: false));

    if (context.mounted) {
      Navigator.pop(context);
    }
  }
}
