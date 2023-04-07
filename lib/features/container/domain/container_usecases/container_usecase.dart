import 'package:dartz/dartz.dart';
import 'package:stuff_scout/core/errors/custom_exception.dart';
import 'package:stuff_scout/core/errors/failure.dart';
import 'package:stuff_scout/core/errors/success.dart';
import 'package:stuff_scout/features/container/data/models/container_model.dart';
import 'package:stuff_scout/features/container/data/repositories/container_repo.dart';

import '../../../../service_locator.dart';
import '../../../item/data/models/item_model.dart';
import '../../../room/data/models/room_model.dart';

class ContainerUsecase {
  final ContainerRepo _containerRepo = sl<ContainerRepo>();

  Future<Either<Failure, List<ContainerModel>>> getContainerModelList(
      List<String> containerIdList) async {
    final List<ContainerModel> containerList = [];

    for (final containerId in containerIdList) {
      try {
        final ContainerModel containerModel =
        await _containerRepo.getContainerModel(containerId);
        containerList.add(containerModel);
      } on CustomException catch (e) {
        return Left(Failure(message: e.message, code: e.code));
      }
    }

    return Right(containerList);
  }

  Future<Either<Failure, Success>> putContainerModel(
      String containerId, ContainerModel containerModel) async {
    try {
      await _containerRepo.addContainerIdToContainerInfo(containerId, containerModel.id);
      await _containerRepo.putContainerModel(containerModel);
      return const Right(Success(message: 'Added Container successfully'));
    } on CustomException catch (e) {
      return Left(Failure(message: e.message, code: e.code));
    }
  }

  Future<Either<Failure, List<ItemModel>>> getItemModelList(
      List<String> itemIdList) async {
    final List<ItemModel> itemList = [];

    for (final itemId in itemIdList) {
      try {
        final ItemModel itemModel = await _containerRepo.getItemModel(itemId);
        itemList.add(itemModel);
      } on CustomException catch (e) {
        return Left(Failure(message: e.message, code: e.code));
      }
    }

    return Right(itemList);
  }

  Future<Either<Failure, Success>> putItemModel(
      String containerId, ItemModel itemModel) async {
    try {
      await _containerRepo.addItemIdToContainerInfo(containerId, itemModel.id);
      await _containerRepo.putItemModel(itemModel);
      return const Right(Success(message: 'Added Item successfully'));
    } on CustomException catch (e) {
      return Left(Failure(message: e.message, code: e.code));
    }
  }

  Future<Either<Failure, Success>> deleteContainerModelFromRoomModel(RoomModel roomModel, ContainerModel containerModel) async {
    try {
      await _containerRepo.deleteContainerIdFromRoomInfo(roomModel.id, containerModel.id);
      await _containerRepo.deleteContainerInfo(containerModel.id);
      return const Right(Success(message: 'Deleted Container successfully'));
    } on CustomException catch (e) {
      return Left(Failure(message: e.message, code: e.code));
    }
  }

  Future<Either<Failure, Success>> deleteContainerModelFromContainerModel(ContainerModel containerModel, ContainerModel nestedContainerModel) async {
    try {
      await _containerRepo.deleteContainerIdFromContainerInfo(containerModel.id, nestedContainerModel.id);
      await _containerRepo.deleteContainerInfo(nestedContainerModel.id);
      return const Right(Success(message: 'Deleted Container successfully'));
    } on CustomException catch (e) {
      return Left(Failure(message: e.message, code: e.code));
    }
  }
}
