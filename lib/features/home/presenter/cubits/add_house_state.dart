part of 'add_house_cubit.dart';

@immutable
class AddHouseState {
  const AddHouseState({
    this.name,
    this.isLoading = false,
  });

  final String? name;
  final bool isLoading;

  AddHouseState copyWith({
    String? name,
    bool? isLoading,
  }) {
    return AddHouseState(
      name: name ?? this.name,
      isLoading: isLoading ?? this.isLoading,
    );
  }
}
