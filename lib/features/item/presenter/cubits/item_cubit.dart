import 'package:bloc/bloc.dart';
import 'package:dartz/dartz.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:meta/meta.dart';
import 'package:stuff_scout/core/errors/failure.dart';
import 'package:stuff_scout/core/errors/success.dart';
import 'package:stuff_scout/core/models/storage_model.dart';

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

  Future<void> deleteItem(StorageModel storageModel) async {
    Future<Either<Failure, Success>>? result;

    if (storageModel is HouseModel) {
      result = _itemUsecase.deleteItemModelFromHouseModel(
          storageModel, state.itemModel);
    } else if (storageModel is RoomModel) {
      result =
          _itemUsecase.deleteItemModelFromRoomModel(storageModel, state.itemModel);
    } else if (storageModel is ContainerModel) {
      result = _itemUsecase.deleteItemModelFromContainerModel(
          storageModel, state.itemModel);
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
          if (storageModel is HouseModel) {
            context.read<HouseCubit>().deleteItem(state.itemModel);
          } else if (storageModel is RoomModel) {
            context.read<RoomCubit>().deleteItem(state.itemModel);
          } else if (storageModel is ContainerModel) {
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
