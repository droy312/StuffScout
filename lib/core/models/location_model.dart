import 'package:stuff_scout/core/services/id_service.dart';
import 'package:stuff_scout/features/container/data/models/container_model.dart';
import 'package:stuff_scout/features/room/domain/entities/room_entity.dart';

import '../../service_locator.dart';

class LocationModel {
  const LocationModel({
    required this.id,
    required this.house,
    this.room,
    this.containerListInOrder,
  });

  final String id;
  final String house;
  final String? room;
  final List<String>? containerListInOrder;

  /// Input: Location(id: '123', house: 'house123', room: 'room123',
  /// containerListInOrder: ['container1', 'container2', 'container3',])
  ///
  /// Output: house123 > room123 > container1 > container2 > container3
  String toLocationString() {
    String location = house;

    if (room != null) {
      location += ' > $room';
    }

    if (containerListInOrder != null) {
      for (final container in containerListInOrder!) {
        location += ' > $container';
      }
    }

    return location;
  }

  LocationModel addRoom(RoomEntity roomEntity) {
    final IdService idService = sl<IdService>();

    return LocationModel(
      id: idService.generateRandomId(),
      house: house,
      room: roomEntity.name,
    );
  }

  LocationModel addContainer(ContainerModel containerEntity) {
    final IdService idService = sl<IdService>();
    final List<String> newContainerListInOrder =
        containerListInOrder != null ? containerListInOrder!.toList() : [];
    newContainerListInOrder.add(containerEntity.name);

    return LocationModel(
      id: idService.generateRandomId(),
      house: house,
      room: room,
      containerListInOrder: newContainerListInOrder,
    );
  }
}
