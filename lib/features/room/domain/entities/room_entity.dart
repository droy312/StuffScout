import 'package:stuff_scout/core/models/location_model.dart';
import 'package:stuff_scout/features/item/data/models/item_model.dart';

import '../../../container/data/models/container_model.dart';

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
  List<ContainerModel> containerList;
  List<ItemModel> itemList;

  void addContainer(ContainerModel containerEntity) {
    List<ContainerModel> newContainerList = containerList.toList();
    newContainerList.add(containerEntity);
    containerList = newContainerList;
  }

  void addItem(ItemModel itemEntity) {
    List<ItemModel> newItemList = itemList.toList();
    newItemList.add(itemEntity);
    itemList = newItemList;
  }
}
