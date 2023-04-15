/// Base Model for HouseModel, RoomMode, ContainerMode, ItemModel
class StorageModel {
  const StorageModel({
    required this.modelId,
    required this.modelName,
  });

  final String modelId;
  final String modelName;

  factory StorageModel.empty() {
    return const StorageModel(
      modelId: 'modelId',
      modelName: 'modelName',
    );
  }
}
