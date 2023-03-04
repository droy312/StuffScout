import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';
import 'package:stuff_scout/features/room/data/models/room_model.dart';

import '../../../container/data/models/container_model.dart';
import '../../../item/data/models/item_model.dart';

part 'room_state.dart';

class RoomCubit extends Cubit<RoomState> {
  RoomCubit({required RoomModel roomEntity})
      : super(RoomState(roomEntity: roomEntity));

  void addContainer(ContainerModel containerEntity) {
    state.roomEntity.addContainer(containerEntity);
    emit(RoomState(roomEntity: state.roomEntity));
  }

  void addItem(ItemModel itemEntity) {
    state.roomEntity.addItem(itemEntity);
    emit(RoomState(roomEntity: state.roomEntity));
  }
}
