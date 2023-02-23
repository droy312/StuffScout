import 'package:stuff_scout/features/room/data/models/room_model.dart';

class HouseModel {
  const HouseModel({
    required this.id,
    required this.name,
    this.imageUrl,
    this.roomList = const [],
    this.mapLocationLink,
  });

  final String id;
  final String name;
  final String? imageUrl;
  final List<RoomModel> roomList;
  final String? mapLocationLink;
}
