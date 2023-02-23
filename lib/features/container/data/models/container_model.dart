import 'package:stuff_scout/core/models/location_model.dart';

import '../../../item/data/models/item_model.dart';

class ContainerModel {
  const ContainerModel({
    required this.id,
    required this.name,
    required this.locationModel,
    this.imageUrl,
    this.containerList = const [],
    this.itemList = const [],
  });

  final String id;
  final String name;
  final LocationModel locationModel;
  final String? imageUrl;
  final List<ContainerModel> containerList;
  final List<ItemModel> itemList;
}
