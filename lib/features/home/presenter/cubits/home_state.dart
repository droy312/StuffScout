part of 'home_cubit.dart';

@immutable
class HomeState {
  const HomeState({
    this.houseList = const [],
    this.isLoading = false,
  });

  final List<HouseModel> houseList;
  final bool isLoading;

  HomeState copyWith({
    List<HouseModel>? houseList,
    bool? isLoading,
  }) {
    return HomeState(
      houseList: houseList ?? this.houseList,
      isLoading: isLoading ?? this.isLoading,
    );
  }
}
