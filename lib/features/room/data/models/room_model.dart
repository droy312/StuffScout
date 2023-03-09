import 'package:stuff_scout/core/models/location_model.dart';
import 'package:stuff_scout/features/item/data/models/item_model.dart';

import '../../../container/data/models/container_model.dart';

class RoomModel {
  RoomModel({
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

  void addContainer(ContainerModel containerModel) {
    List<ContainerModel> newContainerList = containerList.toList();
    newContainerList.add(containerModel);
    containerList = newContainerList;
  }

  void addItem(ItemModel itemModel) {
    List<ItemModel> newItemList = itemList.toList();
    newItemList.add(itemModel);
    itemList = newItemList;
  }

  List<String> get _getContainerIdList =>
      containerList.map((containerModel) => containerModel.id).toList();
  List<String> get _getItemIdList =>
      containerList.map((containerModel) => containerModel.id).toList();

  Map<String, dynamic> toMapForLocalStorage() {
    return {
      'id': id,
      'name': name,
      'description': description,
      'locationModel': locationModel.toMap(),
      'imageUrl': imageUrl,
      'containerList': _getContainerIdList,
      'itemList': _getItemIdList,
    };
  }

  factory RoomModel.fromMapOfLocalStorage(Map<dynamic, dynamic> map) {
    return RoomModel(
      id: map['id'],
      name: map['name'],
      description: map['description'],
      locationModel: LocationModel.fromMapOfLocalStorage(map['locationModel']),
      imageUrl: map['imageUrl'],
    );
  }
}
