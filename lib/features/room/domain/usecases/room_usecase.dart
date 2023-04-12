import 'dart:io';

import 'package:dartz/dartz.dart';
import 'package:stuff_scout/core/errors/custom_exception.dart';
import 'package:stuff_scout/core/errors/failure.dart';
import 'package:stuff_scout/core/errors/success.dart';
import 'package:stuff_scout/features/container/data/models/container_model.dart';
import 'package:stuff_scout/features/room/data/repositories/room_repo.dart';

import '../../../../service_locator.dart';
import '../../../item/data/models/item_model.dart';
import '../../data/models/room_model.dart';

class RoomUsecase {
  final RoomRepo _roomRepo = sl<RoomRepo>();

  Future<Either<Failure, List<ContainerModel>>> getContainerModelList(
      List<String> containerIdList) async {
    final List<ContainerModel> containerList = [];

    for (final containerId in containerIdList) {
      try {
        final ContainerModel containerModel =
            await _roomRepo.getContainerModel(containerId);
        containerList.add(containerModel);
      } on CustomException catch (e) {
        return Left(Failure(message: e.message, code: e.code));
      }
    }

    return Right(containerList);
  }

  Future<Either<Failure, Success>> putContainerModel(
      String roomId, ContainerModel containerModel) async {
    try {
      await _roomRepo.addContainerIdToRoomInfo(roomId, containerModel.id);
      await _roomRepo.putContainerModel(containerModel);
      return const Right(Success(message: 'Added Container successfully'));
    } on CustomException catch (e) {
      return Left(Failure(message: e.message, code: e.code));
    }
  }

  Future<Either<Failure, Success>> deleteContainerModelFromRoomModel(
      RoomModel roomModel, ContainerModel containerModel) async {
    try {
      await _roomRepo.deleteContainerIdFromRoomInfo(
          roomModel.id, containerModel.id);
      await _roomRepo.deleteContainerInfo(containerModel.id);
      return const Right(Success(message: 'Deleted Container successfully'));
    } on CustomException catch (e) {
      return Left(Failure(message: e.message, code: e.code));
    }
  }

  Future<Either<Failure, List<ItemModel>>> getItemModelList(
      List<String> itemIdList) async {
    final List<ItemModel> itemList = [];

    for (final itemId in itemIdList) {
      try {
        final ItemModel itemModel = await _roomRepo.getItemModel(itemId);
        itemList.add(itemModel);
      } on CustomException catch (e) {
        return Left(Failure(message: e.message, code: e.code));
      }
    }

    return Right(itemList);
  }

  Future<Either<Failure, Success>> putItemModel(
      String roomId, ItemModel itemModel) async {
    try {
      await _roomRepo.addItemIdToRoomInfo(roomId, itemModel.id);
      await _roomRepo.putItemModel(itemModel);
      return const Right(Success(message: 'Added Item successfully'));
    } on CustomException catch (e) {
      return Left(Failure(message: e.message, code: e.code));
    }
  }

  Future<Either<Failure, Success>> deleteItemModelFromRoomModel(
      RoomModel roomModel, ItemModel itemModel) async {
    try {
      await _roomRepo.deleteItemIdFromRoomInfo(roomModel.id, itemModel.id);
      await _roomRepo.deleteItemInfo(itemModel.id);
      return const Right(Success(message: 'Deleted Item successfully'));
    } on CustomException catch (e) {
      return Left(Failure(message: e.message, code: e.code));
    }
  }

  Future<Either<Failure, Success>> updateRoomModel(RoomModel roomModel) async {
    try {
      await _roomRepo.updateRoomInfo(roomModel);
      return const Right(Success(message: 'Updated Room successfully'));
    } on CustomException catch (e) {
      return Left(Failure(message: e.message, code: e.code));
    }
  }

  Future<Either<Failure, File?>> getImageFileFromCamera() async {
    try {
      return Right(await _roomRepo.getImageFileFromCamera());
    } on CustomException catch (e) {
      return Left(Failure(message: e.message, code: e.code));
    }
  }

  Future<Either<Failure, File?>> getImageFileFromGallery() async {
    try {
      return Right(await _roomRepo.getImageFileFromGallery());
    } on CustomException catch (e) {
      return Left(Failure(message: e.message, code: e.code));
    }
  }
}
