import 'package:dartz/dartz.dart';
import 'package:stuff_scout/features/item/data/repositories/item_repo.dart';

import '../../../../core/errors/custom_exception.dart';
import '../../../../core/errors/failure.dart';
import '../../../../core/errors/success.dart';
import '../../../../service_locator.dart';
import '../../data/models/item_model.dart';

class ItemUsecase {
  final ItemRepo _itemRepo = sl<ItemRepo>();

  Future<Either<Failure, Success>> updateItemModel(ItemModel itemModel) async {
    try {
      await _itemRepo.updateItemInfo(itemModel);
      return const Right(Success(message: 'Updated Item successfully'));
    } on CustomException catch (e) {
      return Left(Failure(message: e.message, code: e.code));
    }
  }
}