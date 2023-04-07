/// Base Model for HouseModel, RoomMode, ContainerMode, ItemModel
class StorageModel {
  const StorageModel({
    required this.modelId,
  });

  final String modelId;

  factory StorageModel.empty() {
    return const StorageModel(modelId: 'modelId');
  }
}
