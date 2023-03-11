part of 'add_item_cubit.dart';

@immutable
class AddItemState {
  const AddItemState({
    this.name,
    this.isLoading = false,
    this.imageUrl,
  });

  final String? name;
  final bool isLoading;
  final String? imageUrl;

  AddItemState copyWith({
    String? name,
    bool? isLoading,
    String? imageUrl,
  }) {
    return AddItemState(
      name: name ?? this.name,
      isLoading: isLoading ?? this.isLoading,
      imageUrl: imageUrl,
    );
  }
}
