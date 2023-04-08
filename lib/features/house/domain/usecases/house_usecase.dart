import 'dart:io';

import 'package:dartz/dartz.dart';
import 'package:stuff_scout/core/errors/custom_exception.dart';
import 'package:stuff_scout/core/errors/success.dart';
import 'package:stuff_scout/features/house/data/repositories/house_repo.dart';
import 'package:stuff_scout/features/room/data/models/room_model.dart';

import '../../../../core/errors/failure.dart';
import '../../../../service_locator.dart';
import '../../../item/data/models/item_model.dart';
import '../../data/models/house_model.dart';

class HouseUsecase {
  final HouseRepo _houseRepo = sl<HouseRepo>();

  Future<Either<Failure, List<RoomModel>>> getRoomModelList(
      List<String> roomIdList) async {
    try {
      List<RoomModel> roomModelList = [];
      for (final roomId in roomIdList) {
        final RoomModel roomModel = await _houseRepo.getRoomModel(roomId);
        roomModelList.add(roomModel);
      }

      return Right(roomModelList);
    } on CustomException catch (e) {
      return Left(Failure(
        message: e.message,
        code: e.code,
      ));
    }
  }

  Future<Either<Failure, Success>> putRoomModel(
      String houseId, RoomModel roomModel) async {
    try {
      await _houseRepo.putRoomModel(roomModel);
      await _houseRepo.addRoomIdToHouseInfo(houseId, roomModel.id);

      return const Right(Success(message: 'Added Room successfully'));
    } on CustomException catch (e) {
      return Left(Failure(message: e.message, code: e.code));
    }
  }

  Future<Either<Failure, Success>> deleteRoomModelFromHouseModel(
      HouseModel houseModel, RoomModel roomModel) async {
    try {
      await _houseRepo.deleteRoomIdFromHouseInfo(houseModel.id, roomModel.id);
      await _houseRepo.deleteRoomInfo(roomModel.id);
      return const Right(Success(message: 'Deleted Room successfully'));
    } on CustomException catch (e) {
      return Left(Failure(message: e.message, code: e.code));
    }
  }

  Future<Either<Failure, Success>> deleteItemModelFromHouseModel(
      HouseModel houseModel, ItemModel itemModel) async {
    try {
      await _houseRepo.deleteItemIdFromHouseInfo(houseModel.id, itemModel.id);
      await _houseRepo.deleteItemInfo(itemModel.id);
      return const Right(Success(message: 'Deleted Item successfully'));
    } on CustomException catch (e) {
      return Left(Failure(message: e.message, code: e.code));
    }
  }

  Future<Either<Failure, List<ItemModel>>> getItemModelList(
      List<String> itemIdList) async {
    final List<ItemModel> itemList = [];

    for (final itemId in itemIdList) {
      try {
        final ItemModel itemModel = await _houseRepo.getItemModel(itemId);
        itemList.add(itemModel);
      } on CustomException catch (e) {
        return Left(Failure(message: e.message, code: e.code));
      }
    }

    return Right(itemList);
  }

  Future<Either<Failure, Success>> putItemModel(
      String houseId, ItemModel itemModel) async {
    try {
      await _houseRepo.addItemIdToHouseInfo(houseId, itemModel.id);
      await _houseRepo.putItemModel(itemModel);
      return const Right(Success(message: 'Added Item successfully'));
    } on CustomException catch (e) {
      return Left(Failure(message: e.message, code: e.code));
    }
  }

  Future<Either<Failure, File?>> getImageFileFromCamera() async {
    try {
      return Right(await _houseRepo.getImageFileFromCamera());
    } on CustomException catch (e) {
      return Left(Failure(message: e.message, code: e.code));
    }
  }

  Future<Either<Failure, File?>> getImageFileFromGallery() async {
    try {
      return Right(await _houseRepo.getImageFileFromGallery());
    } on CustomException catch (e) {
      return Left(Failure(message: e.message, code: e.code));
    }
  }
}
