part of 'add_room_cubit.dart';

@immutable
class AddRoomState {
  const AddRoomState({
    this.name,
    this.isLoading = false,
  });

  final String? name;
  final bool isLoading;

  AddRoomState copyWith({
    String? name,
    bool? isLoading,
  }) {
    return AddRoomState(
      name: name ?? this.name,
      isLoading: isLoading ?? this.isLoading,
    );
  }
}
