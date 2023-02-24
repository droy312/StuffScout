import 'package:bloc/bloc.dart';
import 'package:flutter/cupertino.dart';
import 'package:meta/meta.dart';

import '../../../house/domain/entities/house_entity.dart';

part 'home_state.dart';

class HomeCubit extends Cubit<HomeState> {
  HomeCubit() : super(const HomeState());

  void addHouse(HouseEntity houseEntity) {
    final List<HouseEntity> houseList = [];
    for (final houseEntity in state.houseList) {
      houseList.add(houseEntity);
    }
    houseList.add(houseEntity);
    emit(HomeState(houseList: houseList));
  }
}
