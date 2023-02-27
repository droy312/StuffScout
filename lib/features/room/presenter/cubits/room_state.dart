part of 'room_cubit.dart';

@immutable
class RoomState {
  const RoomState({
    this.containerList = const [],
    this.itemList = const [],
  });

  final List<ContainerEntity> containerList;
  final List<ItemEntity> itemList;

  RoomState copyWith({
    List<ContainerEntity>? containerList,
    List<ItemEntity>? itemList,
  }) {
    return RoomState(
      containerList: containerList ?? this.containerList,
      itemList: itemList ?? this.itemList,
    );
  }
}
