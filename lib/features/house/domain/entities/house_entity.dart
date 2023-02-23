import 'package:stuff_scout/features/room/domain/entities/room_entity.dart';

class HouseEntity {
  const HouseEntity({
    required this.id,
    required this.name,
    this.imageUrl,
    this.roomList = const [],
    this.mapLocationLink,
  });

  final String id;
  final String name;
  final String? imageUrl;
  final List<RoomEntity> roomList;
  final String? mapLocationLink;
}
