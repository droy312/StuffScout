import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';

import '../../../room/domain/entities/room_entity.dart';

part 'house_state.dart';

class HouseCubit extends Cubit<HouseState> {
  HouseCubit() : super(const HouseState());

  void addRoom(RoomEntity roomEntity) {
    final List<RoomEntity> roomList = state.roomList;
    roomList.add(roomEntity);
    state.copyWith(roomList: roomList);
  }
}
