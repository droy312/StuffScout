import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';
import 'package:stuff_scout/core/models/location_model.dart';

import '../../../room/domain/entities/room_entity.dart';

part 'house_state.dart';

class HouseCubit extends Cubit<HouseState> {
  HouseCubit()
      : super(const HouseState(roomList: [
          RoomEntity(
            id: '123',
            name: 'Dummy Room',
            locationModel: LocationModel(
              id: '123',
              house: 'Dummy House',
            ),
          )
        ]));

  void addRoom(RoomEntity roomEntity) {
    final List<RoomEntity> roomList = [];
    for (final roomEntity in state.roomList) {
      roomList.add(roomEntity);
    }
    roomList.add(roomEntity);
    emit(HouseState(roomList: roomList));
  }
}
