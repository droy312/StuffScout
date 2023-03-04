import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';
import 'package:stuff_scout/features/room/data/models/room_model.dart';

import '../../../container/data/models/container_model.dart';
import '../../../item/data/models/item_model.dart';

part 'room_state.dart';

class RoomCubit extends Cubit<RoomState> {
  RoomCubit({required RoomModel roomModel})
      : super(RoomState(roomModel: roomModel));

  void addContainer(ContainerModel containerModel) {
    state.roomModel.addContainer(containerModel);
    emit(RoomState(roomModel: state.roomModel));
  }

  void addItem(ItemModel itemModel) {
    state.roomModel.addItem(itemModel);
    emit(RoomState(roomModel: state.roomModel));
  }
}
