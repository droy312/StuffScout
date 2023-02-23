import 'package:stuff_scout/core/models/location_model.dart';

class ItemEntity {
  const ItemEntity({
    required this.id,
    required this.name,
    required this.locationModel,
    this.imageUrl,
  });

  final String id;
  final String name;
  final LocationModel locationModel;
  final String? imageUrl;
}
