import 'package:bloc/bloc.dart';
import 'package:dartz/dartz.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:meta/meta.dart';
import 'package:stuff_scout/core/enums/storage_enums.dart';
import 'package:stuff_scout/core/errors/failure.dart';
import 'package:stuff_scout/core/errors/success.dart';

import '../../../../core/widgets/snackbar_widget.dart';
import '../../../../service_locator.dart';
import '../../../container/data/models/container_model.dart';
import '../../../container/presenter/cubits/container_cubit.dart';
import '../../../house/data/models/house_model.dart';
import '../../../house/presenter/cubits/house_cubit.dart';
import '../../../room/data/models/room_model.dart';
import '../../../room/presenter/cubits/room_cubit.dart';
import '../../data/models/item_model.dart';
import '../../domain/usecases/item_usecase.dart';

part 'item_state.dart';

class ItemCubit extends Cubit<ItemState> {
  ItemCubit({
    required this.context,
    required ItemModel itemModel,
  }) : super(ItemState(itemModel: itemModel));

  final ItemUsecase _itemUsecase = sl<ItemUsecase>();

  final BuildContext context;

  Future<void> deleteItem(ItemStorage itemStorage) async {
    Future<Either<Failure, Success>>? result;

    if (itemStorage == ItemStorage.house) {
      final HouseModel houseModel = context.read<HouseCubit>().state.houseModel;
      result = _itemUsecase.deleteItemModelFromHouseModel(
          houseModel, state.itemModel);
    } else if (itemStorage == ItemStorage.room) {
      final RoomModel roomModel = context.read<RoomCubit>().state.roomModel;
      result =
          _itemUsecase.deleteItemModelFromRoomModel(roomModel, state.itemModel);
    } else if (itemStorage == ItemStorage.container) {
      final ContainerModel containerModel =
          context.read<ContainerCubit>().state.containerModel;
      result = _itemUsecase.deleteItemModelFromContainerModel(
          containerModel, state.itemModel);
    }

    if (result != null) {
      (await result).fold(
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
          if (itemStorage == ItemStorage.house) {
            context.read<HouseCubit>().deleteItem(state.itemModel);
          } else if (itemStorage == ItemStorage.room) {
            context.read<RoomCubit>().deleteItem(state.itemModel);
          } else if (itemStorage == ItemStorage.container) {
            context.read<ContainerCubit>().deleteItem(state.itemModel);
          }
          if (context.mounted) {
            Navigator.pop(context);
          }
        },
      );
    }
  }
}
