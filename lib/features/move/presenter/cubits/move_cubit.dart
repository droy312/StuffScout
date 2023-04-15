import 'package:bloc/bloc.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:meta/meta.dart';
import 'package:stuff_scout/core/models/storage_model.dart';
import 'package:stuff_scout/core/widgets/snackbar_widget.dart';
import 'package:stuff_scout/features/container/data/models/container_model.dart';
import 'package:stuff_scout/features/house/data/models/house_model.dart';
import 'package:stuff_scout/features/item/data/models/item_model.dart';
import 'package:stuff_scout/features/room/data/models/room_model.dart';

part 'move_state.dart';

class MoveCubit extends Cubit<MoveState> {
  MoveCubit() : super(const MoveState());

  void setParentStorageModel(StorageModel moveToStorageModel) {
    emit(state.copyWith(moveToStorageModel: moveToStorageModel));
  }

  void copyStorageModel(Function() addFunction, Function() deleteFunction,
      StorageModel copiedFromStorageModel, StorageModel storageModel) {
    deleteFunction();
    emit(state.copyWith(
      copiedFromStorageModel: copiedFromStorageModel,
      storageModel: storageModel,
      addFunction: addFunction,
    ));
  }

  void moveStorageModel(BuildContext context, Function() addFunction) {
    if (state.moveToStorageModel != null && state.storageModel != null) {
      if (state.storageModel is ItemModel) {
        addFunction();

        ScaffoldMessenger.of(context).showSnackBar(CustomSnackBar(
          context: context,
          text: '${state.storageModel!.modelName} Item moved successfully',
        ));

        emit(MoveState(moveToStorageModel: state.moveToStorageModel));
      } else if (state.storageModel is ContainerModel) {
        if (state.moveToStorageModel is HouseModel) {
          ScaffoldMessenger.of(context).showSnackBar(CustomSnackBar(
            context: context,
            text: 'Container can not be moved to House',
            isError: true,
          ));
        } else if (state.moveToStorageModel is ItemModel) {
          ScaffoldMessenger.of(context).showSnackBar(CustomSnackBar(
            context: context,
            text: 'Container can not be moved to Item',
            isError: true,
          ));
        } else if (state.moveToStorageModel is RoomModel) {
          addFunction();

          ScaffoldMessenger.of(context).showSnackBar(CustomSnackBar(
            context: context,
            text:
                '${state.storageModel!.modelName} Container moved successfully',
          ));

          emit(MoveState(moveToStorageModel: state.moveToStorageModel));
        }
      } else if (state.storageModel is RoomModel) {
        if (state.moveToStorageModel is ContainerModel) {
          ScaffoldMessenger.of(context).showSnackBar(CustomSnackBar(
            context: context,
            text: 'Room can not be moved to Container',
            isError: true,
          ));
        } else if (state.storageModel is ItemModel) {
          ScaffoldMessenger.of(context).showSnackBar(CustomSnackBar(
            context: context,
            text: 'Room can not be moved to Item',
            isError: true,
          ));
        } else if (state.moveToStorageModel is HouseModel) {
          addFunction();

          ScaffoldMessenger.of(context).showSnackBar(CustomSnackBar(
            context: context,
            text: '${state.storageModel!.modelName} Room moved successfully',
          ));

          emit(MoveState(moveToStorageModel: state.moveToStorageModel));
        }
      }
    }
  }

  void cancelMove() {
    if (state.addFunction != null) {
      state.addFunction!();
    }

    emit(MoveState(moveToStorageModel: state.moveToStorageModel));
  }

  bool canMoveHere() {
    if (state.moveToStorageModel != null && state.storageModel != null) {
      if (state.storageModel is ItemModel) {
        return true;
      } else if (state.storageModel is ContainerModel) {
        if (state.moveToStorageModel is RoomModel) {
          return true;
        } else {
          return false;
        }
      } else if (state.storageModel is RoomModel) {
        if (state.moveToStorageModel is HouseModel) {
          return true;
        } else {
          return false;
        }
      } else {
        return false;
      }
    } else {
      return false;
    }
  }
}
