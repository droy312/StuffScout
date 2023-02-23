import 'package:stuff_scout/core/models/location_model.dart';

import '../../../container/data/models/container_model.dart';

class RoomModel {
  const RoomModel({
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
  final List<ContainerModel> containerList;
}
