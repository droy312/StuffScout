import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';

import '../../../room/data/models/room_model.dart';
import '../../data/models/house_model.dart';

part 'house_state.dart';

class HouseCubit extends Cubit<HouseState> {
  HouseCubit({required HouseModel houseModel})
      : super(HouseState(houseModel: houseModel));

  void addRoom(RoomModel roomModel) async {
    state.houseModel.addRoom(roomModel);
    emit(HouseState(houseModel: state.houseModel));
  }
}
