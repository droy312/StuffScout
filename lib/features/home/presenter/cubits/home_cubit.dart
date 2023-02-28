import 'package:bloc/bloc.dart';
import 'package:flutter/cupertino.dart';
import 'package:meta/meta.dart';
import 'package:stuff_scout/core/models/location_model.dart';
import 'package:stuff_scout/features/room/domain/entities/room_entity.dart';

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
              RoomEntity(
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

  void addHouse(HouseEntity houseEntity) {
    final List<HouseEntity> houseList = state.houseList.toList();
    houseList.add(houseEntity);
    emit(HomeState(houseList: houseList));
  }
}
