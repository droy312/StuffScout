import 'package:bloc/bloc.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:meta/meta.dart';
import 'package:stuff_scout/core/widgets/snackbar_widget.dart';
import 'package:stuff_scout/features/house/domain/usecases/house_usecase.dart';

import '../../../../service_locator.dart';
import '../../../item/data/models/item_model.dart';
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

    final result1 =
        await _houseUsecase.getRoomModelList(state.houseModel.roomIdList);

    result1.fold((l) {
      if (l.message != null) {
        ScaffoldMessenger.of(context).showSnackBar(CustomSnackBar(
          context: context,
          text: l.message!,
          isError: true,
        ));
      }
    }, (roomList) {
      state.houseModel.addRoomList(roomList);
    });

    final result2 =
        await _houseUsecase.getItemModelList(state.houseModel.itemIdList);
    result2.fold((l) {
      if (l.message != null) {
        ScaffoldMessenger.of(context).showSnackBar(CustomSnackBar(
          context: context,
          text: l.message!,
          isError: true,
        ));
      }
    }, (itemList) {
      state.houseModel.addItemList(itemList);
    });

    emit(HouseState(houseModel: state.houseModel));
  }

  Future<void> addRoom(RoomModel roomModel) async {
    final result =
        await _houseUsecase.putRoomModel(state.houseModel.id, roomModel);
    result.fold((l) {
      if (l.message != null) {
        ScaffoldMessenger.of(context).showSnackBar(CustomSnackBar(
          context: context,
          text: l.message!,
          isError: true,
        ));
      }
    }, (r) {
      state.houseModel.addRoom(roomModel);
      emit(HouseState(houseModel: state.houseModel));

      if (r.message != null) {
        ScaffoldMessenger.of(context).showSnackBar(CustomSnackBar(
          context: context,
          text: r.message!,
        ));
      }
    });
  }

  Future<void> addItem(ItemModel itemModel) async {
    final result =
        await _houseUsecase.putItemModel(state.houseModel.id, itemModel);
    result.fold((l) {
      if (l.message != null) {
        ScaffoldMessenger.of(context).showSnackBar(CustomSnackBar(
          context: context,
          text: l.message!,
          isError: true,
        ));
      }
    }, (r) {
      state.houseModel.addItem(itemModel);
      emit(HouseState(houseModel: state.houseModel));

      if (r.message != null) {
        ScaffoldMessenger.of(context).showSnackBar(CustomSnackBar(
          context: context,
          text: r.message!,
        ));
      }
    });
  }

  void deleteRoom(RoomModel roomModel) {
    state.houseModel.deleteRoom(roomModel);

    emit(HouseState(houseModel: state.houseModel));
  }

  void deleteItem(ItemModel itemModel) {
    state.houseModel.deleteItem(itemModel);

    emit(HouseState(houseModel: state.houseModel));
  }
}
