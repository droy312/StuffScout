import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';
import 'package:stuff_scout/features/house/domain/entities/house_entity.dart';

import '../../../room/domain/entities/room_entity.dart';

part 'house_state.dart';

class HouseCubit extends Cubit<HouseState> {
  HouseCubit({required HouseEntity houseEntity})
      : super(HouseState(houseEntity: houseEntity));

  void addRoom(RoomEntity roomEntity) {
    state.houseEntity.addRoom(roomEntity);
    emit(HouseState(houseEntity: state.houseEntity));
  }
}
