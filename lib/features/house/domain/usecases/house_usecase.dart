import 'dart:io';

import 'package:dartz/dartz.dart';
import 'package:stuff_scout/core/errors/custom_exception.dart';
import 'package:stuff_scout/core/errors/success.dart';
import 'package:stuff_scout/features/house/data/repositories/house_repo.dart';
import 'package:stuff_scout/features/room/data/models/room_model.dart';

import '../../../../core/errors/failure.dart';
import '../../../../service_locator.dart';

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
      return Left(Failure(message: e.message, code: e.code,));
    }
  }

  Future<Either<Failure, Success>> putRoomModel(String houseId, RoomModel roomModel) async {
    try {
      await _houseRepo.putRoomModel(roomModel);
      await _houseRepo.addRoomIdToHouseInfo(houseId, roomModel.id);

      return const Right(Success(message: 'Added Room successfully'));
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
