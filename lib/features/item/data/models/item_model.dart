import 'package:stuff_scout/core/models/location_model.dart';
import 'package:stuff_scout/core/models/storage_model.dart';

class ItemModel extends StorageModel {
  const ItemModel({
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
  }) : super(modelId: id);

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

  Map<String, dynamic> toMapForLocalStorage() {
    return {
      'id': id,
      'name': name,
      'description': description,
      'brand': brand,
      'model': model,
      'serialNumber': serialNumber,
      'quantity': quantity,
      'pricePerItem': pricePerItem,
      'tagList': tagList,
      'locationModel': locationModel.toMap(),
      'imageUrl': imageUrl,
    };
  }

  factory ItemModel.fromMapOfLocalStorage(Map<dynamic, dynamic> map) {
    return ItemModel(
      id: map['id'],
      name: map['name'],
      description: map['description'],
      brand: map['brand'],
      model: map['model'],
      serialNumber: map['serialNumber'],
      quantity: map['quantity'],
      pricePerItem: map['pricePerItem'],
      tagList: map['tagList'],
      locationModel: LocationModel.fromMapOfLocalStorage(map['locationModel']),
      imageUrl: map['imageUrl'],
    );
  }
}
