part of 'add_container_cubit.dart';

@immutable
class AddContainerState {
  const AddContainerState({
    this.name,
    this.isLoading = false,
    this.imageUrl,
  });

  final String? name;
  final bool isLoading;
  final String? imageUrl;

  AddContainerState copyWith({
    String? name,
    bool? isLoading,
    String? imageUrl,
  }) {
    return AddContainerState(
      name: name ?? this.name,
      isLoading: isLoading ?? this.isLoading,
      imageUrl: imageUrl,
    );
  }
}
