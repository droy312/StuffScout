/// Base Model for HouseModel, RoomMode, ContainerMode, ItemModel
class StorageModel {
  const StorageModel({
    required this.id,
    required this.name,
  });

  final String id;
  final String name;

  factory StorageModel.empty() {
    return const StorageModel(
      id: 'id',
      name: 'name',
    );
  }
}
