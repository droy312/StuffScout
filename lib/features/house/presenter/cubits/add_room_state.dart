part of 'add_room_cubit.dart';

@immutable
class AddRoomState {
  const AddRoomState({
    this.name,
    this.isLoading = false,
    this.imageUrl,
  });

  final String? name;
  final bool isLoading;
  final String? imageUrl;

  AddRoomState copyWith({
    String? name,
    bool? isLoading,
    String? imageUrl,
  }) {
    return AddRoomState(
      name: name ?? this.name,
      isLoading: isLoading ?? this.isLoading,
      imageUrl: imageUrl,
    );
  }
}
