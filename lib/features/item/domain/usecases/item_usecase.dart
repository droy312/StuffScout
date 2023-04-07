import 'package:dartz/dartz.dart';
import 'package:stuff_scout/features/item/data/repositories/item_repo.dart';

import '../../../../core/errors/custom_exception.dart';
import '../../../../core/errors/failure.dart';
import '../../../../core/errors/success.dart';
import '../../../../service_locator.dart';
import '../../../container/data/models/container_model.dart';
import '../../../house/data/models/house_model.dart';
import '../../../room/data/models/room_model.dart';
import '../../data/models/item_model.dart';

class ItemUsecase {
  final ItemRepo _itemRepo = sl<ItemRepo>();

  Future<Either<Failure, Success>> deleteItemModelFromHouseModel(HouseModel houseModel, ItemModel itemModel) async {
    try {
      await _itemRepo.deleteItemIdFromHouseInfo(houseModel.id, itemModel.id);
      await _itemRepo.deleteItemInfo(itemModel.id);
      return const Right(Success(message: 'Deleted Item successfully'));
    } on CustomException catch (e) {
      return Left(Failure(message: e.message, code: e.code));
    }
  }

  Future<Either<Failure, Success>> deleteItemModelFromRoomModel(RoomModel roomModel, ItemModel itemModel) async {
    try {
      await _itemRepo.deleteItemIdFromRoomInfo(roomModel.id, itemModel.id);
      await _itemRepo.deleteItemInfo(itemModel.id);
      return const Right(Success(message: 'Deleted Item successfully'));
    } on CustomException catch (e) {
      return Left(Failure(message: e.message, code: e.code));
    }
  }

  Future<Either<Failure, Success>> deleteItemModelFromContainerModel(ContainerModel containerModel, ItemModel itemModel) async {
    try {
      await _itemRepo.deleteItemIdFromContainerInfo(containerModel.id, itemModel.id);
      await _itemRepo.deleteItemInfo(itemModel.id);
      return const Right(Success(message: 'Deleted Item successfully'));
    } on CustomException catch (e) {
      return Left(Failure(message: e.message, code: e.code));
    }
  }
}