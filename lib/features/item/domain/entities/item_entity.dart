import 'package:stuff_scout/core/models/location_model.dart';

class ItemEntity {
  const ItemEntity({
    required this.id,
    required this.name,
    this.description,
    this.brand,
    this.model,
    this.serialNumber,
    this.quantity,
    this.pricePerItem,
    this.tagList,
    required this.locationModel,
    this.imageUrl,
  });

  final String id;
  final String name;
  final String? description;
  final String? brand;
  final String? model;
  final String? serialNumber;
  final int? quantity;
  final double? pricePerItem;
  final List<String>? tagList;
  final LocationModel locationModel;
  final String? imageUrl;
}
