import 'package:stuff_scout/core/services/id_service.dart';
import 'package:stuff_scout/features/container/data/models/container_model.dart';
import 'package:stuff_scout/features/room/data/models/room_model.dart';

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

  LocationModel addRoom(RoomModel roomModel) {
    final IdService idService = sl<IdService>();

    return LocationModel(
      id: idService.generateRandomId(),
      house: house,
      room: roomModel.name,
    );
  }

  LocationModel addContainer(ContainerModel containerModel) {
    final IdService idService = sl<IdService>();
    final List<String> newContainerListInOrder =
        containerListInOrder != null ? containerListInOrder!.toList() : [];
    newContainerListInOrder.add(containerModel.name);

    return LocationModel(
      id: idService.generateRandomId(),
      house: house,
      room: room,
      containerListInOrder: newContainerListInOrder,
    );
  }

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

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'house': house,
      'room': room,
      'containerListInOrder': containerListInOrder,
    };
  }

  factory LocationModel.fromMapOfLocalStorage(Map<dynamic, dynamic> map) {
    return LocationModel(
      id: map['id'],
      house: map['house'],
      room: map['room'],
      containerListInOrder: map['containerListInOrder'],
    );
  }

  factory LocationModel.empty() {
    return const LocationModel(
      id: 'id',
      house: 'house',
    );
  }
}
