import 'package:bloc/bloc.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:meta/meta.dart';
import 'package:stuff_scout/core/widgets/snackbar_widget.dart';
import 'package:stuff_scout/features/container/domain/container_usecases/container_usecase.dart';
import 'package:stuff_scout/features/item/domain/usecases/item_usecase.dart';
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
  final ContainerUsecase _containerUsecase = sl<ContainerUsecase>();
  final ItemUsecase _itemUsecase = sl<ItemUsecase>();

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

  Future<void> addContainer(ContainerModel containerModel,
      {bool showSuccessSnackbar = true}) async {
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

      if (r.message != null && showSuccessSnackbar) {
        ScaffoldMessenger.of(context).showSnackBar(CustomSnackBar(
          context: context,
          text: r.message!,
        ));
      }
    });
  }

  Future<void> addItem(ItemModel itemModel,
      {bool showSuccessSnackbar = true}) async {
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

      if (r.message != null && showSuccessSnackbar) {
        ScaffoldMessenger.of(context).showSnackBar(CustomSnackBar(
          context: context,
          text: r.message!,
        ));
      }
    });
  }

  Future<void> deleteContainer(ContainerModel containerModel,
      {bool showSuccessSnackbar = true}) async {
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
        if (r.message != null && showSuccessSnackbar) {
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

  Future<void> deleteItem(ItemModel itemModel,
      {bool showSuccessSnackbar = true}) async {
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
        if (r.message != null && showSuccessSnackbar) {
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

  Future<void> updateContainer(ContainerModel containerModel) async {
    final result = await _containerUsecase.updateContainerModel(containerModel);
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

        final List<ContainerModel> containerList = [];
        for (final container in state.roomModel.containerList) {
          if (container.id != containerModel.id) {
            containerList.add(container);
          } else {
            containerList.add(containerModel);
          }
        }

        state.roomModel.addContainerList(containerList);
        emit(RoomState(roomModel: state.roomModel));
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
        for (final item in state.roomModel.itemList) {
          if (item.id != itemModel.id) {
            itemList.add(item);
          } else {
            itemList.add(itemModel);
          }
        }

        state.roomModel.addItemList(itemList);
        emit(RoomState(roomModel: state.roomModel));
      },
    );
  }
}
