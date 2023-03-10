import 'package:hive_flutter/hive_flutter.dart';

import '../../service_locator.dart';

class LocalStorageService {
  static const String _userInfoBoxName = 'userInfoBox';
  static const String _houseBoxName = 'houseBox';
  static const String _roomBoxName = 'roomBox';
  static const String _containerBoxName = 'containerBox';
  static const String _itemBoxName = 'itemBox';

  static const String _houseIdListKey = 'houseIdList';

  final HiveInterface _hive = sl<HiveInterface>();

  late final Box _userInfoBox;
  late final Box _houseBox;
  late final Box _roomBox;
  late final Box _containerBox;
  late final Box _itemBox;

  /// Initializes Hive and opens houses, rooms, containers, items box
  Future<void> init() async {
    await _hive.initFlutter();
    _userInfoBox = await _hive.openBox(_userInfoBoxName);
    _houseBox = await _hive.openBox(_houseBoxName);
    _roomBox = await _hive.openBox(_roomBoxName);
    _containerBox = await _hive.openBox(_containerBoxName);
    _itemBox = await _hive.openBox(_itemBoxName);
  }

  void deleteBoxFromDisk() {
    _userInfoBox.deleteFromDisk();
    _houseBox.deleteFromDisk();
    _roomBox.deleteFromDisk();
    _containerBox.deleteFromDisk();
    _itemBox.deleteFromDisk();
  }

  Future<void> _addIdToList(
      Box box, String key, String mapKey, String id) async {
    Map<dynamic, dynamic> map = box.get(key);
    List<dynamic> list = map[mapKey].toList();
    list.add(id);
    map[mapKey] = list;
    await box.put(key, map);
  }

  // Home

  Future<void> addHouseIdToHouseIdList(String houseId) async {
    final List<String> list =
        (_userInfoBox.get(_houseIdListKey, defaultValue: []) as List<dynamic>)
            .map((e) => e.toString())
            .toList();
    list.add(houseId);
    await _userInfoBox.put(_houseIdListKey, list);
  }

  Future<List<String>?> getHouseIdList() async {
    return _userInfoBox.get(_houseIdListKey) as List<String>?;
  }

  // House

  Future<void> putHouseInfo(
      String houseId, Map<String, dynamic> houseMap) async {
    await _houseBox.put(houseId, houseMap);
  }

  Future<void> addRoomIdToHouseInfo(String houseId, String roomId) {
    return _addIdToList(_houseBox, houseId, 'roomIdList', roomId);
  }

  Future<Map<dynamic, dynamic>?> getHouseInfo(String houseId) async {
    return _houseBox.get(houseId);
  }

  // Room

  Future<void> putRoomInfo(String roomId, Map<String, dynamic> roomMap) async {
    await _roomBox.put(roomId, roomMap);
  }

  Future<void> addContainerIdToRoomInfo(String roomId, String containerId) {
    return _addIdToList(_roomBox, roomId, 'containerIdList', containerId);
  }

  Future<void> addItemIdToRoomInfo(String roomId, String itemId) {
    return _addIdToList(_roomBox, roomId, 'itemIdList', itemId);
  }

  Future<Map<dynamic, dynamic>?> getRoomInfo(String roomId) async {
    return _roomBox.get(roomId);
  }

  // Container

  Future<void> putContainerInfo(
      String containerId, Map<String, dynamic> containerMap) async {
    await _containerBox.put(containerId, containerMap);
  }

  Future<void> addContainerIdToContainerInfo(
      String containerId, String nestedContainerId) {
    return _addIdToList(
        _containerBox, containerId, 'containerIdList', nestedContainerId);
  }

  Future<void> addItemIdToContainerInfo(String containerId, String itemId) {
    return _addIdToList(_containerBox, containerId, 'itemIdList', itemId);
  }

  Future<Map<dynamic, dynamic>?> getContainerInfo(String containerId) async {
    return _containerBox.get(containerId);
  }

  // Item

  Future<void> putItemInfo(String itemId, Map<String, dynamic> itemMap) async {
    await _itemBox.put(itemId, itemMap);
  }

  Future<Map<dynamic, dynamic>?> getItemInfo(String itemId) async {
    return _itemBox.get(itemId);
  }
}
