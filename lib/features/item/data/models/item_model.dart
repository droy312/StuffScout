import 'package:stuff_scout/core/models/location_model.dart';

class ItemModel {
  const ItemModel({
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
