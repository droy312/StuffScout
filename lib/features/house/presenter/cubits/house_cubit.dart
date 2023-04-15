import 'package:bloc/bloc.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:meta/meta.dart';
import 'package:stuff_scout/core/widgets/snackbar_widget.dart';
import 'package:stuff_scout/features/house/domain/usecases/house_usecase.dart';
import 'package:stuff_scout/features/item/domain/usecases/item_usecase.dart';
import 'package:stuff_scout/features/room/domain/usecases/room_usecase.dart';

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
  final RoomUsecase _roomUsecase = sl<RoomUsecase>();
  final ItemUsecase _itemUsecase = sl<ItemUsecase>();

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

  Future<void> addRoom(RoomModel roomModel, {bool showSuccessSnackbar = true}) async {
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

      if (r.message != null && showSuccessSnackbar) {
        ScaffoldMessenger.of(context).showSnackBar(CustomSnackBar(
          context: context,
          text: r.message!,
        ));
      }
    });
  }

  Future<void> addItem(ItemModel itemModel, {bool showSuccessSnackbar = true}) async {
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

      if (r.message != null && showSuccessSnackbar) {
        ScaffoldMessenger.of(context).showSnackBar(CustomSnackBar(
          context: context,
          text: r.message!,
        ));
      }
    });
  }

  Future<void> deleteRoom(RoomModel roomModel, {bool showSuccessSnackbar = true}) async {
    emit(state.copyWith(isLoading: true));

    final result = await _houseUsecase.deleteRoomModelFromHouseModel(
        state.houseModel, roomModel);
    result.fold(
          (l) {
        if (l.message != null) {
          ScaffoldMessenger.of(context).showSnackBar(CustomSnackBar(
            context: context,
            text: l.message!,
            isError: true,
          ));
        }
      },
          (r) {
        if (r.message != null && showSuccessSnackbar) {
          ScaffoldMessenger.of(context).showSnackBar(CustomSnackBar(
            context: context,
            text: r.message!,
          ));
        }

        state.houseModel.deleteRoom(roomModel);
      },
    );

    emit(HouseState(houseModel: state.houseModel));
  }

  Future<void> deleteItem(ItemModel itemModel, {bool showSuccessSnackbar = true}) async {
    emit(state.copyWith(isLoading: true));

    final result = await _houseUsecase.deleteItemModelFromHouseModel(
          state.houseModel, itemModel);

    result.fold(
          (l) {
        if (l.message != null) {
          ScaffoldMessenger.of(context).showSnackBar(CustomSnackBar(
            context: context,
            text: l.message!,
            isError: true,
          ));
        }
      },
          (r) {
        if (r.message != null && showSuccessSnackbar) {
          ScaffoldMessenger.of(context).showSnackBar(CustomSnackBar(
            context: context,
            text: r.message!,
          ));
        }

        state.houseModel.deleteItem(itemModel);
      },
    );

    emit(HouseState(houseModel: state.houseModel));
  }

  Future<void> updateRoom(RoomModel roomModel) async {
    final result = await _roomUsecase.updateRoomModel(roomModel);
    result.fold(
          (l) {
        if (l.message != null) {
          ScaffoldMessenger.of(context).showSnackBar(CustomSnackBar(
            context: context,
            text: l.message!,
            isError: true,
          ));
        }
      },
          (r) {
        if (r.message != null) {
          ScaffoldMessenger.of(context).showSnackBar(CustomSnackBar(
            context: context,
            text: r.message!,
          ));
        }

        final List<RoomModel> roomList = [];
        for (final room in state.houseModel.roomList) {
          if (room.id != roomModel.id) {
            roomList.add(room);
          } else {
            roomList.add(roomModel);
          }
        }

        state.houseModel.addRoomList(roomList);
        emit(HouseState(houseModel: state.houseModel));
      },
    );
  }

  Future<void> updateItem(ItemModel itemModel) async {
    final result = await _itemUsecase.updateItemModel(itemModel);
    result.fold(
          (l) {
        if (l.message != null) {
          ScaffoldMessenger.of(context).showSnackBar(CustomSnackBar(
            context: context,
            text: l.message!,
            isError: true,
          ));
        }
      },
          (r) {
        if (r.message != null) {
          ScaffoldMessenger.of(context).showSnackBar(CustomSnackBar(
            context: context,
            text: r.message!,
          ));
        }

        final List<ItemModel> itemList = [];
        for (final item in state.houseModel.itemList) {
          if (item.id != itemModel.id) {
            itemList.add(item);
          } else {
            itemList.add(itemModel);
          }
        }

        state.houseModel.addItemList(itemList);
        emit(HouseState(houseModel: state.houseModel));
      },
    );
  }
}
