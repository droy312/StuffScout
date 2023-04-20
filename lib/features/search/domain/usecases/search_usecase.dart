import 'package:dartz/dartz.dart';
import 'package:stuff_scout/core/errors/custom_exception.dart';
import 'package:stuff_scout/core/errors/failure.dart';
import 'package:stuff_scout/features/search/data/repositories/search_repo.dart';

import '../../../../service_locator.dart';
import '../../../container/data/models/container_model.dart';
import '../../../house/data/models/house_model.dart';
import '../../../item/data/models/item_model.dart';
import '../../../room/data/models/room_model.dart';

class SearchUsecase {
  final SearchRepo _searchRepo = sl<SearchRepo>();

  Future<Either<Failure, List<RoomModel>>> getRoomList(
      List<String> roomIdList) async {
    try {
      return Right(await _searchRepo.getRoomList(roomIdList));
    } on CustomException catch (e) {
      return Left(Failure(code: e.code, message: e.message));
    }
  }

  Future<Either<Failure, List<ContainerModel>>> getContainerList(
      List<String> containerIdList) async {
    try {
      final List<ContainerModel> list =
          await _searchRepo.getContainerList(containerIdList);
      final int listSize = list.length;

      for (int index = 0; index < listSize; index++) {
        final ContainerModel containerModel = list[index];
        final result = await getContainerList(containerModel.containerIdList);
        result.fold(
          (l) {
            return Left(l);
          },
          (containerList) {
            list.addAll(containerList);
          },
        );
      }

      return Right(list);
    } on CustomException catch (e) {
      return Left(Failure(code: e.code, message: e.message));
    }
  }

  Future<Either<Failure, List<ItemModel>>> getItemList(
      List<String> itemIdList) async {
    try {
      return Right(await _searchRepo.getItemList(itemIdList));
    } on CustomException catch (e) {
      return Left(Failure(code: e.code, message: e.message));
    }
  }

  List<HouseModel> searchHouseList(
      List<HouseModel> houseList, String searchText) {
    final List<HouseModel> searchedHouseList = [];

    for (final houseModel in houseList) {
      if (houseModel.name.toLowerCase().contains(searchText.toLowerCase()) || (houseModel.description != null &&
          houseModel.description!
              .toLowerCase()
              .contains(searchText.toLowerCase()))) {
        searchedHouseList.add(houseModel);
      }
    }

    return searchedHouseList;
  }

  List<RoomModel> searchRoomList(List<RoomModel> roomList, String searchText) {
    final List<RoomModel> searchedRoomList = [];

    for (final roomModel in roomList) {
      if (roomModel.name.toLowerCase().contains(searchText.toLowerCase()) || (roomModel.description != null &&
          roomModel.description!
              .toLowerCase()
              .contains(searchText.toLowerCase()))) {
        searchedRoomList.add(roomModel);
      }
    }

    return searchedRoomList;
  }

  List<ContainerModel> searchContainerList(
      List<ContainerModel> containerList, String searchText) {
    final List<ContainerModel> searchedContainerList = [];

    for (final containerModel in containerList) {
      if (containerModel.name
          .toLowerCase()
          .contains(searchText.toLowerCase()) || (containerModel.description != null &&
          containerModel.description!
              .toLowerCase()
              .contains(searchText.toLowerCase()))) {
        searchedContainerList.add(containerModel);
      }
    }

    return searchedContainerList;
  }

  List<ItemModel> searchItemList(List<ItemModel> itemList, String searchText) {
    final List<ItemModel> searchedItemList = [];

    for (final itemModel in itemList) {
      if (itemModel.name.toLowerCase().contains(searchText.toLowerCase()) ||
          (itemModel.description != null &&
              itemModel.description!
                  .toLowerCase()
                  .contains(searchText.toLowerCase())) ||
          (itemModel.brand != null &&
              itemModel.brand!
                  .toLowerCase()
                  .contains(searchText.toLowerCase())) ||
          (itemModel.model != null &&
              itemModel.model!
                  .toLowerCase()
                  .contains(searchText.toLowerCase()))) {
        searchedItemList.add(itemModel);
      } else {
        if (itemModel.tagList != null) {
          for (final tag in itemModel.tagList!) {
            if (tag.toLowerCase().contains(searchText.toLowerCase())) {
              searchedItemList.add(itemModel);
              break;
            }
          }
        }
      }
    }

    return searchedItemList;
  }
}
