import 'dart:io';

import 'package:stuff_scout/core/errors/custom_exception.dart';
import 'package:stuff_scout/core/services/local_storage_service.dart';
import 'package:stuff_scout/core/strs.dart';

import '../../../../core/services/image_picker_service.dart';
import '../../../../service_locator.dart';
import '../../../room/data/models/room_model.dart';

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
