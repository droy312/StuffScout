import 'package:stuff_scout/core/services/local_storage_service.dart';

import '../../../../core/errors/custom_exception.dart';
import '../../../../service_locator.dart';

class ItemRepo {
  final LocalStorageService _localStorageService = sl<LocalStorageService>();

  Future<void> deleteItemIdFromHouseInfo(String houseId, String itemId) async {
    try {
      return _localStorageService.deleteItemIdFromHouseInfo(houseId, itemId);
    } catch (e) {
      throw const CustomException(
          message: 'Couldn\'t delete Item. Please try again.');
    }
  }

  Future<void> deleteItemIdFromRoomInfo(String roomId, String itemId) async {
    try {
      return _localStorageService.deleteItemIdFromRoomInfo(roomId, itemId);
    } catch (e) {
      throw const CustomException(
          message: 'Couldn\'t delete Item. Please try again.');
    }
  }

  Future<void> deleteItemIdFromContainerInfo(String containerId, String itemId) async {
    try {
      return _localStorageService.deleteItemIdFromContainerInfo(containerId, itemId);
    } catch (e) {
      throw const CustomException(
          message: 'Couldn\'t delete Item. Please try again.');
    }
  }

  Future<void> deleteItemInfo(String itemId) async {
    try {
      return _localStorageService.deleteItemInfo(itemId);
    } catch (e) {
      throw const CustomException(
          message: 'Couldn\'t delete Item. Please try again.');
    }
  }
}