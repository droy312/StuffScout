import 'package:stuff_scout/core/models/storage_model.dart';

import '../../../item/data/models/item_model.dart';
import '../../../room/data/models/room_model.dart';

class HouseModel extends StorageModel {
  HouseModel({
    required String id,
    required String name,
    this.description,
    this.imageUrl,
    this.roomList = const [],
    this.roomIdList = const [],
    this.itemList = const [],
    this.itemIdList = const [],
    this.mapLocationLink,
  }) : super(
          id: id,
          name: name,
        );

  final String? description;
  final String? imageUrl;
  List<RoomModel> roomList;
  List<String> roomIdList;
  List<ItemModel> itemList;
  List<String> itemIdList;
  final String? mapLocationLink;

  void addRoomList(List<RoomModel> roomList) {
    this.roomList = roomList;

    List<String> newRoomIdList =
    roomList.map((roomModel) => roomModel.id).toList();
    roomIdList = newRoomIdList;
  }

  void addRoom(RoomModel roomModel) {
    roomList.add(roomModel);
    roomIdList.add(roomModel.id);
  }

  void addItemList(List<ItemModel> itemList) {
    this.itemList = itemList;

    List<String> newItemIdList =
    itemList.map((itemModel) => itemModel.id).toList();
    itemIdList = newItemIdList;
  }

  void addItem(ItemModel itemModel) {
    itemList.add(itemModel);
    itemIdList.add(itemModel.id);
  }

  void deleteRoom(RoomModel roomModel) {
    roomList.remove(roomModel);
    roomIdList.removeWhere((roomId) => roomId == roomModel.id);
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
      'imageUrl': imageUrl,
      'roomIdList': roomIdList,
      'itemIdList': itemIdList,
      'mapLocationLink': mapLocationLink,
    };
  }

  factory HouseModel.fromMapOfLocalStorage(Map<dynamic, dynamic>? map) {
    if (map == null) {
      throw Exception('Data from house local storage was null');
    }

    return HouseModel(
      id: map['id'],
      name: map['name'],
      description: map['description'],
      imageUrl: map['imageUrl'],
      roomIdList: ((map['roomIdList'] ?? []) as List<dynamic>)
          .map((roomId) => roomId.toString())
          .toList(),
      itemIdList: ((map['itemIdList'] ?? []) as List<dynamic>)
          .map((itemId) => itemId.toString())
          .toList(),
      mapLocationLink: map['mapLocationLink'],
    );
  }

  factory HouseModel.empty() {
    return HouseModel(
      id: 'id',
      name: 'name',
    );
  }
}
