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

  Future<void> putHouseInfo(
      String houseId, Map<String, dynamic> houseMap) async {
    await _houseBox.put(houseId, houseMap);
    final List<String> houseIdList = _userInfoBox.get(_houseIdListKey,
        defaultValue: [].map((e) => e.toString()).toList()) as List<String>;
    houseIdList.add(houseId);
    await _userInfoBox.put(_houseIdListKey, houseIdList);
  }

  Future<List<String>?> getHouseIdList() async {
    return _userInfoBox.get(_houseIdListKey) as List<String>?;
  }

  Future<Map<dynamic, dynamic>?> getHouseInfo(String houseId) async {
    return _houseBox.get(houseId);
  }
}
