import 'package:stuff_scout/core/errors/custom_exception.dart';
import 'package:stuff_scout/core/services/local_storage_service.dart';

import '../../../../service_locator.dart';
import '../../../container/data/models/container_model.dart';
import '../../../item/data/models/item_model.dart';
import '../../../room/data/models/room_model.dart';

class SearchRepo {
  final LocalStorageService _localStorageService = sl<LocalStorageService>();

  Future<List<Map<dynamic, dynamic>>> _getList(
      List<String>? idList,
      Future<Map<dynamic, dynamic>?> Function(String) getInfo,
      String errorMessage) async {
    try {
      if (idList == null) {
        throw CustomException(message: errorMessage);
      }

      final List<dynamic> list = [];
      for (final id in idList) {
        final Map<dynamic, dynamic>? map = await getInfo(id);
        if (map == null) {
          throw CustomException(message: errorMessage);
        }

        list.add(map);
      }

      return list.map((e) => e as Map<dynamic, dynamic>).toList();
    } catch (e) {
      throw CustomException(message: errorMessage);
    }
  }

  Future<List<RoomModel>> getRoomList(List<String> roomIdList) async {
    try {
      final List<Map<dynamic, dynamic>> mapList = await _getList(roomIdList,
          _localStorageService.getRoomInfo, 'Couldn\'t get rooms info');
      return mapList
          .map((map) => RoomModel.fromMapOfLocalStorage(map))
          .toList();
    } catch (e) {
      throw const CustomException(message: 'Couldn\'t get rooms info');
    }
  }

  Future<List<ContainerModel>> getContainerList(List<String> containerIdList) async {
    try {
      final List<Map<dynamic, dynamic>> mapList = await _getList(containerIdList,
          _localStorageService.getContainerInfo, 'Couldn\'t get containers info');
      return mapList
          .map((map) => ContainerModel.fromMapOfLocalStorage(map))
          .toList();
    } catch (e) {
      throw const CustomException(message: 'Couldn\'t get containers info');
    }
  }

  Future<List<ItemModel>> getItemList(List<String> itemIdList) async {
    try {
      final List<Map<dynamic, dynamic>> mapList = await _getList(itemIdList,
          _localStorageService.getItemInfo, 'Couldn\'t get items info');
      return mapList
          .map((map) => ItemModel.fromMapOfLocalStorage(map))
          .toList();
    } catch (e) {
      throw const CustomException(message: 'Couldn\'t get items info');
    }
  }
}
