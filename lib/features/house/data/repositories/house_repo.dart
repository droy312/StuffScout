import 'dart:io';

import 'package:stuff_scout/core/errors/custom_exception.dart';
import 'package:stuff_scout/core/services/local_storage_service.dart';
import 'package:stuff_scout/core/strs.dart';

import '../../../../core/services/image_picker_service.dart';
import '../../../../service_locator.dart';
import '../../../item/data/models/item_model.dart';
import '../../../room/data/models/room_model.dart';
import '../models/house_model.dart';

class HouseRepo {
  final LocalStorageService _localStorageService = sl<LocalStorageService>();
  final ImagePickerService _imagePickerService = sl<ImagePickerService>();


  Future<RoomModel> getRoomModel(String roomId) async {
    final Map<dynamic, dynamic>? map =
        await _localStorageService.getRoomInfo(roomId);

    if (map == null) {
      throw const CustomException(message: Strs.thereWasSomeProblem);
    }

    return RoomModel.fromMapOfLocalStorage(map);
  }

  Future<void> addRoomIdToHouseInfo(String houseId, String roomId) async {
    try {
      return _localStorageService.addRoomIdToHouseInfo(houseId, roomId);
    } catch (e) {
      throw const CustomException(
          message: 'Couldn\t add Room. Please try again.');
    }
  }

  Future<void> putRoomModel(RoomModel roomModel) async {
    try {
      final Map<String, dynamic> map = roomModel.toMapForLocalStorage();
      await _localStorageService.putRoomInfo(roomModel.id, map);
    } catch (e) {
      throw const CustomException(
          message: 'Couldn\'t add Room. Please try again.');
    }
  }

  Future<void> deleteRoomIdFromHouseInfo(String houseId, String roomId) async {
    try {
      return _localStorageService.deleteRoomIdFromHouseInfo(houseId, roomId);
    } catch (e) {
      throw const CustomException(
          message: 'Couldn\'t delete Room. Please try again.');
    }
  }

  Future<void> deleteRoomInfo(String roomId) async {
    try {
      return _localStorageService.deleteRoomInfo(roomId);
    } catch (e) {
      throw const CustomException(
          message: 'Couldn\'t delete Room. Please try again.');
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

  Future<void> addItemIdToHouseInfo(String houseId, String itemId) async {
    try {
      await _localStorageService.addItemIdToHouseInfo(houseId, itemId);
    } catch (e) {
      throw const CustomException(
          message: 'Couldn\'t add Item. Please try again.');
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

  Future<void> deleteItemIdFromHouseInfo(String houseId, String itemId) async {
    try {
      return _localStorageService.deleteItemIdFromHouseInfo(houseId, itemId);
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

  Future<void> updateHouseInfo(HouseModel houseModel) async {
    try {
      return _localStorageService.updateHouseInfo(houseModel.id, houseModel.toMapForLocalStorage());
    } catch (e) {
      throw const CustomException(message: 'Chouln\'t update House. Please try again');
    }
  }

  Future<File?> getImageFileFromCamera() {
    try {
      return _imagePickerService.getImageFileFromCamera();
    } catch (e) {
      throw const CustomException(
          message: 'Failed to get image. Please try again.');
    }
  }

  Future<File?> getImageFileFromGallery() {
    try {
      return _imagePickerService.getImageFileFromGallery();
    } catch (e) {
      throw const CustomException(
          message: 'Failed to get image. Please try again.');
    }
  }
}
