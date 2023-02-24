part of 'home_cubit.dart';

@immutable
class HomeState {
  const HomeState({this.houseList = const []});

  final List<HouseEntity> houseList;
}
