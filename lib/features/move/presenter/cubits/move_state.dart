part of 'move_cubit.dart';

@immutable
class MoveState {
  const MoveState({
    this.copiedFromStorageModel,
    this.moveToStorageModel,
    this.storageModel,
    this.addFunction,
  });

  final StorageModel? copiedFromStorageModel;
  final StorageModel? moveToStorageModel;
  final StorageModel? storageModel;
  /// This function is called when the user cancels the move
  /// this function will add the storageModel in the local database
  final Function()? addFunction;

  MoveState copyWith({
    StorageModel? copiedFromStorageModel,
    StorageModel? moveToStorageModel,
    StorageModel? storageModel,
    Function()? addFunction,
  }) {
    return MoveState(
      copiedFromStorageModel: copiedFromStorageModel ?? this.copiedFromStorageModel,
      moveToStorageModel: moveToStorageModel ?? this.moveToStorageModel,
      storageModel: storageModel ?? this.storageModel,
      addFunction: addFunction ?? this.addFunction,
    );
  }
}
