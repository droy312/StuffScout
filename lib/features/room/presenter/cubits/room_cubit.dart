import 'package:bloc/bloc.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:meta/meta.dart';
import 'package:stuff_scout/core/widgets/snackbar_widget.dart';
import 'package:stuff_scout/features/room/data/models/room_model.dart';
import 'package:stuff_scout/features/room/domain/usecases/room_usecase.dart';

import '../../../../service_locator.dart';
import '../../../container/data/models/container_model.dart';
import '../../../item/data/models/item_model.dart';

part 'room_state.dart';

class RoomCubit extends Cubit<RoomState> {
  RoomCubit({
    required this.context,
    required RoomModel roomModel,
  }) : super(RoomState(roomModel: roomModel));

  final RoomUsecase _roomUsecase = sl<RoomUsecase>();

  final BuildContext context;

  void init() async {
    emit(state.copyWith(isLoading: true));

    final result = await _roomUsecase
        .getContainerModelList(state.roomModel.containerIdList);
    result.fold((l) {
      if (l.message != null) {
        ScaffoldMessenger.of(context).showSnackBar(CustomSnackBar(
          context: context,
          text: l.message!,
          isError: true,
        ));
      }
    }, (containerList) {
      state.roomModel.addContainerList(containerList);
    });

    final result2 =
        await _roomUsecase.getItemModelList(state.roomModel.itemIdList);
    result2.fold((l) {
      if (l.message != null) {
        ScaffoldMessenger.of(context).showSnackBar(CustomSnackBar(
          context: context,
          text: l.message!,
          isError: true,
        ));
      }
    }, (itemList) {
      state.roomModel.addItemList(itemList);
    });

    emit(RoomState(roomModel: state.roomModel));
  }

  Future<void> addContainer(ContainerModel containerModel) async {
    final result = await _roomUsecase.putContainerModel(
        state.roomModel.id, containerModel);
    result.fold((l) {
      if (l.message != null) {
        ScaffoldMessenger.of(context).showSnackBar(CustomSnackBar(
          context: context,
          text: l.message!,
          isError: true,
        ));
      }
    }, (r) {
      state.roomModel.addContainer(containerModel);
      emit(RoomState(roomModel: state.roomModel));

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
        await _roomUsecase.putItemModel(state.roomModel.id, itemModel);
    result.fold((l) {
      if (l.message != null) {
        ScaffoldMessenger.of(context).showSnackBar(CustomSnackBar(
          context: context,
          text: l.message!,
          isError: true,
        ));
      }
    }, (r) {
      state.roomModel.addItem(itemModel);
      emit(RoomState(roomModel: state.roomModel));

      if (r.message != null) {
        ScaffoldMessenger.of(context).showSnackBar(CustomSnackBar(
          context: context,
          text: r.message!,
        ));
      }
    });
  }

  Future<void> deleteContainer(ContainerModel containerModel) async {
    emit(state.copyWith(isLoading: true));

    final result = await _roomUsecase.deleteContainerModelFromRoomModel(
          state.roomModel, containerModel);

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

        state.roomModel.deleteContainer(containerModel);
      },
    );

    emit(RoomState(roomModel: state.roomModel));
  }

  Future<void> deleteItem(ItemModel itemModel) async {
    emit(state.copyWith(isLoading: true));

    final result = await _roomUsecase.deleteItemModelFromRoomModel(
        state.roomModel, itemModel);

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

        state.roomModel.deleteItem(itemModel);
      },
    );

    emit(RoomState(roomModel: state.roomModel));
  }
}
