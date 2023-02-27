import 'package:stuff_scout/core/models/location_model.dart';

import '../../../item/domain/entities/item_entity.dart';

class ContainerEntity {
  const ContainerEntity({
    required this.id,
    required this.name,
    this.description,
    required this.locationModel,
    this.imageUrl,
    this.containerList = const [],
    this.itemList = const [],
  });

  final String id;
  final String name;
  final String? description;
  final LocationModel locationModel;
  final String? imageUrl;
  final List<ContainerEntity> containerList;
  final List<ItemEntity> itemList;
}
