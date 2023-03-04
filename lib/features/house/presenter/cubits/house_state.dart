part of 'house_cubit.dart';

@immutable
class HouseState {
  const HouseState({
    required this.houseEntity,
    this.isLoading = false,
  });

  final HouseModel houseEntity;
  final bool isLoading;

  HouseState copyWith({
    HouseModel? houseEntity,
    bool? isLoading,
  }) {
    return HouseState(
      houseEntity: houseEntity ?? this.houseEntity,
      isLoading: isLoading ?? this.isLoading,
    );
  }
}
