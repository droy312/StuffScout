part of 'room_cubit.dart';

@immutable
class RoomState {
  const RoomState({
    required this.roomModel,
    this.isLoading = false,
  });

  final RoomModel roomModel;
  final bool isLoading;

  RoomState copyWith({
    RoomModel? roomModel,
    bool? isLoading,
  }) {
    return RoomState(
      roomModel: roomModel ?? this.roomModel,
      isLoading: isLoading ?? this.isLoading,
    );
  }
}
