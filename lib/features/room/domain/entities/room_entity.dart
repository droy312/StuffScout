import 'package:stuff_scout/core/models/location_model.dart';
import 'package:stuff_scout/features/item/domain/entities/item_entity.dart';

import '../../../container/domain/entities/container_entity.dart';

class RoomEntity {
  RoomEntity({
    required this.id,
    required this.name,
    this.description,
    required this.locationModel,
    this.imageUrl,
    this.containerList = const [],
    this.itemList = const [],
  });

  final String id;
  final String name;
  final String? description;
  final LocationModel locationModel;
  final String? imageUrl;
  List<ContainerEntity> containerList;
  List<ItemEntity> itemList;

  void addContainer(ContainerEntity containerEntity) {
    List<ContainerEntity> newContainerList = [];
    for (final containerEntity in containerList) {
      newContainerList.add(containerEntity);
    }
    newContainerList.add(containerEntity);
    containerList = newContainerList;
  }

  void addItem(ItemEntity itemEntity) {
    List<ItemEntity> newItemList = [];
    for (final itemEntity in itemList) {
      newItemList.add(itemEntity);
    }
    newItemList.add(itemEntity);
    itemList = newItemList;
  }
}
