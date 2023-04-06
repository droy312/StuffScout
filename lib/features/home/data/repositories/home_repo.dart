import 'dart:io';

import 'package:stuff_scout/core/errors/custom_exception.dart';
import 'package:stuff_scout/core/services/image_picker_service.dart';
import 'package:stuff_scout/core/strs.dart';
import 'package:stuff_scout/features/house/data/models/house_model.dart';

import '../../../../core/services/local_storage_service.dart';
import '../../../../service_locator.dart';

class HomeRepo {
  final LocalStorageService _localStorageService = sl<LocalStorageService>();
  final ImagePickerService _imagePickerService = sl<ImagePickerService>();

  Future<List<String>> getHouseIdList() async {
    return await _localStorageService.getHouseIdList() ?? [];
  }

  Future<HouseModel> getHouseModel(String houseId) async {
    final Map<dynamic, dynamic>? map =
        await _localStorageService.getHouseInfo(houseId);

    if (map == null) {
      throw const CustomException(message: Strs.thereWasSomeProblem);
    }

    return HouseModel.fromMapOfLocalStorage(map);
  }

  Future<void> addHouseIdToHouseIdList(String houseId) async {
    try {
      return _localStorageService.addHouseIdToHouseIdList(houseId);
    } catch (e) {
      throw const CustomException(
          message: 'Couldn\'t add House. Please try again');
    }
  }

  Future<void> putHouseModel(HouseModel houseModel) async {
    try {
      final Map<String, dynamic> map = houseModel.toMapForLocalStorage();
      await _localStorageService.putHouseInfo(houseModel.id, map);
    } catch (e) {
      throw const CustomException(
          message: 'Couldn\'t add House. Please try again');
    }
  }

  Future<void> deleteHouseIdFromHouseIdList(String houseId) async {
    try {
      return _localStorageService.deleteHouseIdFromHouseIdList(houseId);
    } catch (e) {
      throw const CustomException(message: 'Couldn\'t delete House. Please try again');
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
