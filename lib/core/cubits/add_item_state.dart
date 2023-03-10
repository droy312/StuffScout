part of 'add_item_cubit.dart';

@immutable
class AddItemState {
  const AddItemState({
    this.name,
    this.isLoading = false,
  });

  final String? name;
  final bool isLoading;

  AddItemState copyWith({
    String? name,
    bool? isLoading,
  }) {
    return AddItemState(
      name: name ?? this.name,
      isLoading: isLoading ?? this.isLoading,
    );
  }
}
