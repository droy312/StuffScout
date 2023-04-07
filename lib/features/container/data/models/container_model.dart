import 'package:stuff_scout/core/errors/custom_exception.dart';
import 'package:stuff_scout/core/models/location_model.dart';

import '../../../item/data/models/item_model.dart';

class ContainerModel {
  ContainerModel({
    required this.id,
    required this.name,
    this.description,
    required this.locationModel,
    this.imageUrl,
    this.containerList = const [],
    this.containerIdList = const [],
    this.itemList = const [],
    this.itemIdList = const [],
  });

  final String id;
  final String name;
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
    List<ContainerModel> newContainerList = containerList.toList();
    newContainerList.add(containerModel);
    containerList = newContainerList;
  }

  void addItemList(List<ItemModel> itemList) {
    this.itemList = itemList;

    final List<String> newItemIdList =
        itemList.map((itemModel) => itemModel.id).toList();
    itemIdList = newItemIdList;
  }

  void addItem(ItemModel itemModel) {
    List<ItemModel> newItemList = itemList.toList();
    newItemList.add(itemModel);
    itemList = newItemList;
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

  factory ContainerModel.fromMapOfLocalStorage(Map<dynamic, dynamic> map) {
    if (map['id'] == null || map['name'] == null) {
      throw const CustomException(
          message:
              'id and name is null in ContainerModel.fromMapOfLocalStorage');
    }

    return ContainerModel(
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

  factory ContainerModel.empty() {
    return ContainerModel(
      id: 'id',
      name: 'name',
      locationModel: LocationModel.empty(),
    );
  }
}
