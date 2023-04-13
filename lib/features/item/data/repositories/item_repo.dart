import 'package:stuff_scout/core/services/local_storage_service.dart';

import '../../../../core/errors/custom_exception.dart';
import '../../../../service_locator.dart';
import '../models/item_model.dart';

class ItemRepo {
  final LocalStorageService _localStorageService = sl<LocalStorageService>();

  Future<void> updateItemInfo(ItemModel itemModel) async {
    try {
      return _localStorageService.updateItemInfo(itemModel.id, itemModel.toMapForLocalStorage());
    } catch (e) {
      throw const CustomException(message: 'Chouln\'t update Item. Please try again');
    }
  }
}