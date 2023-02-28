import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';
import 'package:stuff_scout/features/room/domain/entities/room_entity.dart';

import '../../../container/domain/entities/container_entity.dart';
import '../../../item/domain/entities/item_entity.dart';

part 'room_state.dart';

class RoomCubit extends Cubit<RoomState> {
  RoomCubit({required RoomEntity roomEntity})
      : super(RoomState(roomEntity: roomEntity));

  void addContainer(ContainerEntity containerEntity) {
    state.roomEntity.addContainer(containerEntity);
    emit(RoomState(roomEntity: state.roomEntity));
  }

  void addItem(ItemEntity itemEntity) {
    state.roomEntity.addItem(itemEntity);
    emit(RoomState(roomEntity: state.roomEntity));
  }
}
