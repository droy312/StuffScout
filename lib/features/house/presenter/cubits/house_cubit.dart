import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';

import '../../../room/data/models/room_model.dart';
import '../../data/models/house_model.dart';

part 'house_state.dart';

class HouseCubit extends Cubit<HouseState> {
  HouseCubit({required HouseModel houseEntity})
      : super(HouseState(houseEntity: houseEntity));

  void addRoom(RoomModel roomEntity) async {
    state.houseEntity.addRoom(roomEntity);
    emit(HouseState(houseEntity: state.houseEntity));
  }
}
