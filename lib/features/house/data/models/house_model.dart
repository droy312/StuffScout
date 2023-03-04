import '../../../room/data/models/room_model.dart';

class HouseModel {
  HouseModel({
    required this.id,
    required this.name,
    this.description,
    this.imageUrl,
    this.roomList = const [],
    this.mapLocationLink,
  });

  final String id;
  final String name;
  final String? description;
  final String? imageUrl;
  List<RoomModel> roomList;
  final String? mapLocationLink;

  void addRoom(RoomModel roomEntity) {
    List<RoomModel> newRoomList = roomList.toList();
    newRoomList.add(roomEntity);
    roomList = newRoomList;
  }

  Map<String, dynamic> toMapForLocalStorage() {
    return {
      'id': id,
      'name': name,
      'description': description,
      'imageUrl': imageUrl,
      'roomIdList': [],
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
      mapLocationLink: map['mapLocationLink'],
    );
  }
}