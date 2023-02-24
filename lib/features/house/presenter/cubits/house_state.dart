part of 'house_cubit.dart';

@immutable
class HouseState {
  const HouseState({
    this.roomList = const [],
  });

  final List<RoomEntity> roomList;

  HouseState copyWith({
    List<RoomEntity>? roomList,
  }) {
    return HouseState(roomList: roomList ?? this.roomList);
  }
}
