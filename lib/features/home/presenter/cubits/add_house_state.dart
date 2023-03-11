part of 'add_house_cubit.dart';

@immutable
class AddHouseState {
  const AddHouseState({
    this.name,
    this.imageUrl,
    this.isLoading = false,
  });

  final String? name;
  final String? imageUrl;
  final bool isLoading;

  AddHouseState copyWith({
    String? name,
    String? imageUrl,
    bool? isLoading,
  }) {
    return AddHouseState(
      name: name ?? this.name,
      imageUrl: imageUrl,
      isLoading: isLoading ?? this.isLoading,
    );
  }
}
