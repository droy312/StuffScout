import 'package:bloc/bloc.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:meta/meta.dart';
import 'package:stuff_scout/core/models/location_model.dart';
import 'package:stuff_scout/core/strs.dart';
import 'package:stuff_scout/features/home/domain/usercases/home_usecase.dart';
import 'package:stuff_scout/features/room/data/models/room_model.dart';

import '../../../../service_locator.dart';
import '../../../house/domain/entities/house_entity.dart';

part 'home_state.dart';

class HomeCubit extends Cubit<HomeState> {
  HomeCubit()
      : super(HomeState(houseList: [
          HouseEntity(
            id: '123',
            name: 'Dummy House',
            description: 'Some description of the house',
            roomList: [
              RoomModel(
                id: '123',
                name: 'Dummy Room',
                locationModel: const LocationModel(
                  id: '123',
                  house: 'Dummy House',
                ),
              ),
            ],
          )
        ]));

  final HomeUsecase _homeUsecase = sl<HomeUsecase>();

  void init(BuildContext context) async {
    emit(state.copyWith(isLoading: true));

    List<HouseEntity> houseList = [];
    final result = await _homeUsecase.getHouseEntityList();
    result.fold((l) {
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text(l.message ?? Strs.thereWasSomeProblem)));
    }, (r) {
      houseList = r;
    });

    emit(HomeState(houseList: houseList));
  }

  void addHouse(HouseEntity houseEntity) {
    final List<HouseEntity> houseList = state.houseList.toList();
    houseList.add(houseEntity);
    emit(state.copyWith(houseList: houseList));
    _homeUsecase.putHouseEntity(houseEntity);
  }
}
