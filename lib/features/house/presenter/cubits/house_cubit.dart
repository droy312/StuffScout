import 'package:bloc/bloc.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:meta/meta.dart';
import 'package:stuff_scout/core/widgets/snackbar_widget.dart';
import 'package:stuff_scout/features/house/domain/usecases/house_usecase.dart';

import '../../../../service_locator.dart';
import '../../../room/data/models/room_model.dart';
import '../../data/models/house_model.dart';

part 'house_state.dart';

class HouseCubit extends Cubit<HouseState> {
  HouseCubit({
    required this.context,
    required HouseModel houseModel,
  }) : super(HouseState(houseModel: houseModel));

  final HouseUsecase _houseUsecase = sl<HouseUsecase>();

  final BuildContext context;

  void init() async {
    emit(state.copyWith(isLoading: true));

    final result =
        await _houseUsecase.getRoomModelList(state.houseModel.roomIdList);
    result.fold((l) {
      if (l.message != null) {
        ScaffoldMessenger.of(context).showSnackBar(SnackBarWidget(
          context: context,
          text: l.message!,
          isError: true,
        ));
      }
    }, (roomList) {
      state.houseModel.addRoomList(roomList);
      emit(state);
    });

    emit(state.copyWith(isLoading: false));
  }

  void addRoom(RoomModel roomModel) async {
    final result =
        await _houseUsecase.putRoomModel(state.houseModel.id, roomModel);
    result.fold((l) {
      if (l.message != null) {
        ScaffoldMessenger.of(context).showSnackBar(SnackBarWidget(
          context: context,
          text: l.message!,
          isError: true,
        ));
      }
    }, (r) {
      state.houseModel.addRoom(roomModel);
      emit(state);

      if (r.message != null) {
        ScaffoldMessenger.of(context).showSnackBar(SnackBarWidget(
          context: context,
          text: r.message!,
        ));
      }
    });
  }
}
