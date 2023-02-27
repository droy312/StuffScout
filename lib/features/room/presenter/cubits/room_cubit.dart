import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';
import 'package:stuff_scout/core/models/location_model.dart';

import '../../../container/domain/entities/container_entity.dart';
import '../../../item/domain/entities/item_entity.dart';

part 'room_state.dart';

class RoomCubit extends Cubit<RoomState> {
  RoomCubit()
      : super(
          const RoomState(
            containerList: [
              ContainerEntity(
                id: '123',
                name: 'Dummy Container',
                locationModel: LocationModel(
                  id: '123',
                  house: 'Dummy House',
                  room: 'Dummy Room',
                ),
              ),
            ],
            itemList: [
              ItemEntity(
                id: '123',
                name: 'Dummy Item',
                locationModel: LocationModel(
                  id: '123',
                  house: 'Dummy House',
                  room: 'Dummy Room',
                ),
              ),
            ],
          ),
        );

  void addContainer(ContainerEntity containerEntity) {
    final List<ContainerEntity> containerList = [];
    for (final containerEntity in state.containerList) {
      containerList.add(containerEntity);
    }
    containerList.add(containerEntity);
    emit(state.copyWith(containerList: containerList));
  }

  void addItem(ItemEntity itemEntity) {
    final List<ItemEntity> itemList = [];
    for (final itemEntity in state.itemList) {
      itemList.add(itemEntity);
    }
    itemList.add(itemEntity);
    emit(state.copyWith(itemList: itemList));
  }
}
