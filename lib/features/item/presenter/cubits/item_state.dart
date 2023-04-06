part of 'item_cubit.dart';

@immutable
class ItemState {
  const ItemState({
    required this.itemModel,
    this.isLoading = false,
  });

  final ItemModel itemModel;
  final bool isLoading;

  ItemState copyWith({
    ItemModel? itemModel,
    bool? isLoading,
  }) {
    return ItemState(
      itemModel: itemModel ?? this.itemModel,
      isLoading: isLoading ?? this.isLoading,
    );
  }
}
