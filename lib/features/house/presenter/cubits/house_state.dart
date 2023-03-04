part of 'house_cubit.dart';

@immutable
class HouseState {
  const HouseState({
    required this.houseModel,
    this.isLoading = false,
  });

  final HouseModel houseModel;
  final bool isLoading;

  HouseState copyWith({
    HouseModel? houseModel,
    bool? isLoading,
  }) {
    return HouseState(
      houseModel: houseModel ?? this.houseModel,
      isLoading: isLoading ?? this.isLoading,
    );
  }
}
