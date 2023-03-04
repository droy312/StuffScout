part of 'house_cubit.dart';

@immutable
class HouseState {
  const HouseState({
    required this.houseEntity,
    this.isLoading = false,
  });

  final HouseEntity houseEntity;
  final bool isLoading;

  HouseState copyWith({
    HouseEntity? houseEntity,
    bool? isLoading,
  }) {
    return HouseState(
      houseEntity: houseEntity ?? this.houseEntity,
      isLoading: isLoading ?? this.isLoading,
    );
  }
}
