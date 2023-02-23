import 'package:stuff_scout/core/models/location_model.dart';

import '../../../container/domain/entities/container_entity.dart';

class RoomEntity {
  const RoomEntity({
    required this.id,
    required this.name,
    required this.locationModel,
    this.imageUrl,
    this.containerList = const [],
  });

  final String id;
  final String name;
  final LocationModel locationModel;
  final String? imageUrl;
  final List<ContainerEntity> containerList;
}
