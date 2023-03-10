import '../../../room/data/models/room_model.dart';

class HouseModel {
  HouseModel({
    required this.id,
    required this.name,
    this.description,
    this.imageUrl,
    this.roomList = const [],
    this.roomIdList = const [],
    this.mapLocationLink,
  });

  final String id;
  final String name;
  final String? description;
  final String? imageUrl;
  List<RoomModel> roomList;
  List<String> roomIdList;
  final String? mapLocationLink;

  void addRoom(RoomModel roomModel) {
    List<RoomModel> newRoomList = roomList.toList();
    newRoomList.add(roomModel);
    roomList = newRoomList;

    List<String> newRoomIdList = roomIdList.toList();
    newRoomIdList.add(roomModel.id);
    roomIdList = newRoomIdList;
  }

  void addRoomList(List<RoomModel> roomList) {
    this.roomList = roomList;

    List<String> newRoomIdList = roomList.map((roomModel) => roomModel.id).toList();
    roomIdList = newRoomIdList;
  }

  Map<String, dynamic> toMapForLocalStorage() {
    return {
      'id': id,
      'name': name,
      'description': description,
      'imageUrl': imageUrl,
      'roomIdList': roomIdList,
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
      roomIdList: (map['roomIdList'] as List<dynamic>)
          .map((roomId) => roomId.toString())
          .toList(),
      mapLocationLink: map['mapLocationLink'],
    );
  }
}
