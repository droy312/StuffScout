import 'package:bloc/bloc.dart';
import 'package:dartz/dartz.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:meta/meta.dart';
import 'package:stuff_scout/core/models/storage_model.dart';
import 'package:stuff_scout/features/container/domain/container_usecases/container_usecase.dart';

import '../../../../core/errors/failure.dart';
import '../../../../core/errors/success.dart';
import '../../../../core/widgets/snackbar_widget.dart';
import '../../../../service_locator.dart';
import '../../../room/data/models/room_model.dart';
import '../../../room/presenter/cubits/room_cubit.dart';
import '../../data/models/container_model.dart';
import '../../../item/data/models/item_model.dart';

part 'container_state.dart';

class ContainerCubit extends Cubit<ContainerState> {
  ContainerCubit() : super(ContainerState(containerModel: ContainerModel.empty()));
  
  final ContainerUsecase _containerUsecase = sl<ContainerUsecase>();

  void init(BuildContext context, ContainerModel containerModel) async {
    emit(ContainerState(containerModel: containerModel, isLoading: true));

    final result = await _containerUsecase
        .getContainerModelList(state.containerModel.containerIdList);
    result.fold((l) {
      if (l.message != null) {
        ScaffoldMessenger.of(context).showSnackBar(CustomSnackBar(
          context: context,
          text: l.message!,
          isError: true,
        ));
      }
    }, (containerList) {
      state.containerModel.addContainerList(containerList);
    });

    final result2 =
        await _containerUsecase.getItemModelList(state.containerModel.itemIdList);
    result2.fold((l) {
      if (l.message != null) {
        ScaffoldMessenger.of(context).showSnackBar(CustomSnackBar(
          context: context,
          text: l.message!,
          isError: true,
        ));
      }
    }, (itemList) {
      state.containerModel.addItemList(itemList);
    });

    emit(ContainerState(containerModel: state.containerModel));
  }

  Future<void> addContainer(BuildContext context, ContainerModel containerModel) async {
    final result = await _containerUsecase.putContainerModel(
        state.containerModel.id, containerModel);
    result.fold((l) {
      if (l.message != null) {
        ScaffoldMessenger.of(context).showSnackBar(CustomSnackBar(
          context: context,
          text: l.message!,
          isError: true,
        ));
      }
    }, (r) {
      state.containerModel.addContainer(containerModel);
      emit(ContainerState(containerModel: state.containerModel));

      if (r.message != null) {
        ScaffoldMessenger.of(context).showSnackBar(CustomSnackBar(
          context: context,
          text: r.message!,
        ));
      }
    });
  }

  Future<void> addItem(BuildContext context, ItemModel itemModel) async {
    final result = await _containerUsecase.putItemModel(
        state.containerModel.id, itemModel);
    result.fold((l) {
      if (l.message != null) {
        ScaffoldMessenger.of(context).showSnackBar(CustomSnackBar(
          context: context,
          text: l.message!,
          isError: true,
        ));
      }
    }, (r) {
      state.containerModel.addItem(itemModel);
      emit(ContainerState(containerModel: state.containerModel));

      if (r.message != null) {
        ScaffoldMessenger.of(context).showSnackBar(CustomSnackBar(
          context: context,
          text: r.message!,
        ));
      }
    });
  }

  Future<void> deleteContainer(BuildContext context, StorageModel storageModel) async {
    Future<Either<Failure, Success>>? result;

    if (storageModel is RoomModel) {
      result =
          _containerUsecase.deleteContainerModelFromRoomModel(storageModel, state.containerModel);
    } else if (storageModel is ContainerModel) {
      result = _containerUsecase.deleteContainerModelFromContainerModel(storageModel, state.containerModel);
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
          if (storageModel is RoomModel) {
            context.read<RoomCubit>().deleteContainer(state.containerModel);
          } else if (storageModel is ContainerModel) {
            storageModel.deleteContainer(state.containerModel);
          }
          if (context.mounted) {
            Navigator.pop(context);
          }
        },
      );
    }
  }

  void deleteItem(ItemModel itemModel) {
    state.containerModel.deleteItem(itemModel);

    emit(ContainerState(containerModel: state.containerModel));
  }
}
