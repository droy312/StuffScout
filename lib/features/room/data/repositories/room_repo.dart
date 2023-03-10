import 'package:stuff_scout/core/services/local_storage_service.dart';

import '../../../../core/errors/custom_exception.dart';
import '../../../../core/strs.dart';
import '../../../../service_locator.dart';
import '../../../container/data/models/container_model.dart';
import '../../../item/data/models/item_model.dart';

class RoomRepo {
  final LocalStorageService _localStorageService = sl();

  Future<ContainerModel> getContainerModel(String containerId) async {
    final Map<dynamic, dynamic>? map =
    await _localStorageService.getContainerInfo(containerId);

    if (map == null) {
      throw const CustomException(message: Strs.thereWasSomeProblem);
    }

    return ContainerModel.fromMapOfLocalStorage(map);
  }

  Future<void> addContainerIdToRoomInfo(String roomId, String containerId) async {
    try {
      await _localStorageService.addContainerIdToRoomInfo(roomId, containerId);
    } catch (e) {
      throw const CustomException(message: 'Couldn\'t add Container. Please try again.');
    }
  }

  Future<void> putContainerModel(ContainerModel containerModel) async {
    try {
      final Map<String, dynamic> map = containerModel.toMapForLocalStorage();
      await _localStorageService.putContainerInfo(containerModel.id, map);
    } catch (e) {
      throw const CustomException(
          message: 'Couldn\'t add Container. Please try again.');
    }
  }

  Future<ItemModel> getItemModel(String itemId) async {
    final Map<dynamic, dynamic>? map =
    await _localStorageService.getItemInfo(itemId);

    if (map == null) {
      throw const CustomException(message: Strs.thereWasSomeProblem);
    }

    return ItemModel.fromMapOfLocalStorage(map);
  }

  Future<void> addItemIdToRoomInfo(String roomId, String itemId) async {
    try {
      await _localStorageService.addItemIdToRoomInfo(roomId, itemId);
    } catch (e) {
      throw const CustomException(message: 'Couldn\'t add Item. Please try again.');
    }
  }

  Future<void> putItemModel(ItemModel itemModel) async {
    try {
      final Map<String, dynamic> map = itemModel.toMapForLocalStorage();
      await _localStorageService.putItemInfo(itemModel.id, map);
    } catch (e) {
      throw const CustomException(
          message: 'Couldn\'t add Item. Please try again.');
    }
  }
}