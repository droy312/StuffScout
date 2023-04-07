import 'package:stuff_scout/core/services/local_storage_service.dart';

import '../../../../core/errors/custom_exception.dart';
import '../../../../core/strs.dart';
import '../../../../service_locator.dart';
import '../../../container/data/models/container_model.dart';
import '../../../item/data/models/item_model.dart';

class ContainerRepo {
  final LocalStorageService _localStorageService = sl();

  Future<ContainerModel> getContainerModel(String containerId) async {
    final Map<dynamic, dynamic>? map =
    await _localStorageService.getContainerInfo(containerId);

    if (map == null) {
      throw const CustomException(message: Strs.thereWasSomeProblem);
    }

    return ContainerModel.fromMapOfLocalStorage(map);
  }

  Future<void> addContainerIdToContainerInfo(String containerId, String nestedContainerId) async {
    try {
      await _localStorageService.addContainerIdToContainerInfo(containerId, nestedContainerId);
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

  Future<void> addItemIdToContainerInfo(String containerId, String itemId) async {
    try {
      await _localStorageService.addItemIdToContainerInfo(containerId, itemId);
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

  Future<void> deleteContainerIdFromRoomInfo(String roomId, String containerId) async {
    try {
      return _localStorageService.deleteContainerIdFromRoomInfo(roomId, containerId);
    } catch (e) {
      throw const CustomException(
          message: 'Couldn\'t delete Container. Please try again.');
    }
  }

  Future<void> deleteContainerIdFromContainerInfo(String containerId, String nestedContainerId) async {
    try {
      return _localStorageService.deleteContainerIdFromContainerInfo(containerId, nestedContainerId);
    } catch (e) {
      throw const CustomException(
          message: 'Couldn\'t delete Container. Please try again.');
    }
  }

  Future<void> deleteContainerInfo(String containerId) async {
    try {
      return _localStorageService.deleteContainerInfo(containerId);
    } catch (e) {
      throw const CustomException(
          message: 'Couldn\'t delete Container. Please try again.');
    }
  }
}