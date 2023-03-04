import 'package:dartz/dartz.dart';
import 'package:stuff_scout/core/errors/custom_exception.dart';
import 'package:stuff_scout/features/home/data/repositories/home_repo.dart';

import '../../../../core/errors/failure.dart';
import '../../../../service_locator.dart';
import '../../../house/data/models/house_model.dart';

class HomeUsecase {
  final HomeRepo _homeRepo = sl<HomeRepo>();

  Future<Either<Failure, List<HouseModel>>> getHouseModelList() async {
    final List<String> houseIdList = await _homeRepo.getHouseIdList();

    final List<HouseModel> houseList = [];
    for (final houseId in houseIdList) {
      try {
        final HouseModel houseModel = await _homeRepo.getHouseModel(houseId);
        houseList.add(houseModel);
      } on CustomException catch (e) {
        return Left(Failure(
          code: e.code,
          message: e.message,
        ));
      }
    }

    return Right(houseList);
  }

  Future<void> putHouseModel(HouseModel houseModel) async {
    await _homeRepo.putHouseModel(houseModel);
  }
}
