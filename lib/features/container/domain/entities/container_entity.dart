import 'package:stuff_scout/core/models/location_model.dart';

import '../../../item/domain/entities/item_entity.dart';

class ContainerEntity {
  ContainerEntity({
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
    List<ContainerEntity> newContainerList = containerList.toList();
    newContainerList.add(containerEntity);
    containerList = newContainerList;
  }

  void addItem(ItemEntity itemEntity) {
    List<ItemEntity> newItemList = itemList.toList();
    newItemList.add(itemEntity);
    itemList = newItemList;
  }
}
