import 'package:stuff_scout/features/house/data/models/house_model.dart';
import 'package:stuff_scout/features/room/domain/entities/room_entity.dart';

class HouseEntity {
  HouseEntity({
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
  List<RoomEntity> roomList;
  final String? mapLocationLink;

  void addRoom(RoomEntity roomEntity) {
    List<RoomEntity> newRoomList = roomList.toList();
    newRoomList.add(roomEntity);
    roomList = newRoomList;
  }

  HouseModel toHouseModel() {
    return HouseModel(
      id: id,
      name: name,
      description: description,
      imageUrl: imageUrl,
      mapLocationLink: mapLocationLink,
    );
  }
}
