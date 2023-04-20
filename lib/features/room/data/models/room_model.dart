import 'package:stuff_scout/core/models/location_model.dart';
import 'package:stuff_scout/core/models/storage_model.dart';
import 'package:stuff_scout/features/item/data/models/item_model.dart';

import '../../../container/data/models/container_model.dart';

class RoomModel extends StorageModel {
  RoomModel({
    required String id,
    required String name,
    this.description,
    required this.locationModel,
    this.imageUrl,
    this.containerList = const [],
    this.containerIdList = const [],
    this.itemList = const [],
    this.itemIdList = const [],
  }) : super(
          id: id,
          name: name,
        );

  final String? description;
  final LocationModel locationModel;
  final String? imageUrl;
  List<ContainerModel> containerList;
  List<String> containerIdList;
  List<ItemModel> itemList;
  List<String> itemIdList;

  void addContainerList(List<ContainerModel> containerList) {
    this.containerList = containerList;

    final List<String> newContainerIdList =
        containerList.map((containerModel) => containerModel.id).toList();
    containerIdList = newContainerIdList;
  }

  void addContainer(ContainerModel containerModel) {
    containerList.add(containerModel);
    containerIdList.add(containerModel.id);
  }

  void addItemList(List<ItemModel> itemList) {
    this.itemList = itemList;

    final List<String> newItemIdList =
        itemList.map((itemModel) => itemModel.id).toList();
    itemIdList = newItemIdList;
  }

  void addItem(ItemModel itemModel) {
    itemList.add(itemModel);
    itemIdList.add(itemModel.id);
  }

  void deleteContainer(ContainerModel containerModel) {
    containerList.remove(containerModel);
    containerIdList
        .removeWhere((containerId) => containerId == containerModel.id);
  }

  void deleteItem(ItemModel itemModel) {
    itemList.remove(itemModel);
    itemIdList.removeWhere((itemId) => itemId == itemModel.id);
  }

  Map<String, dynamic> toMapForLocalStorage() {
    return {
      'id': id,
      'name': name,
      'description': description,
      'locationModel': locationModel.toMap(),
      'imageUrl': imageUrl,
      'containerIdList': containerIdList,
      'itemIdList': itemIdList,
    };
  }

  factory RoomModel.fromMapOfLocalStorage(Map<dynamic, dynamic> map) {
    return RoomModel(
      id: map['id'],
      name: map['name'],
      description: map['description'],
      locationModel: LocationModel.fromMapOfLocalStorage(map['locationModel']),
      imageUrl: map['imageUrl'],
      containerIdList: ((map['containerIdList'] ?? []) as List<dynamic>)
          .map((e) => e.toString())
          .toList(),
      itemIdList: ((map['itemIdList'] ?? []) as List<dynamic>)
          .map((e) => e.toString())
          .toList(),
    );
  }

  factory RoomModel.empty() {
    return RoomModel(
      id: 'id',
      name: 'name',
      locationModel: LocationModel.empty(),
    );
  }
}
