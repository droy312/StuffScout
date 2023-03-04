import 'package:stuff_scout/features/house/domain/entities/house_entity.dart';

class HouseModel extends HouseEntity {
  HouseModel({
    required String id,
    required String name,
    final String? description,
    final String? imageUrl,
    final String? mapLocationLink,
  }) : super(
          id: id,
          name: name,
          description: description,
          imageUrl: imageUrl,
          roomList: [],
          mapLocationLink: mapLocationLink,
        );

  Map<String, dynamic> toMapForLocalStorage() {
    return {
      'id': id,
      'name': name,
      'description': description,
      'imageUrl': imageUrl,
      'roomIdList': [],
      'mapLocationLink': mapLocationLink,
    };
  }

  factory HouseModel.fromMapOfLocalStorage(Map<dynamic, dynamic>? map) {
    if (map == null) {
      throw Exception('Data from house local storage was null');
    }

    return HouseModel(
      id: map['id'],
      name: map['name'],
      description: map['description'],
      imageUrl: map['imageUrl'],
      mapLocationLink: map['mapLocationLink'],
    );
  }
}
