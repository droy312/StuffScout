import 'package:dartz/dartz.dart';
import 'package:stuff_scout/core/errors/custom_exception.dart';
import 'package:stuff_scout/features/home/data/repositories/home_repo.dart';

import '../../../../core/errors/failure.dart';
import '../../../../service_locator.dart';
import '../../../house/data/models/house_model.dart';

class HomeUsecase {
  final HomeRepo _homeRepo = sl<HomeRepo>();

  Future<Either<Failure, List<HouseModel>>> getHouseEntityList() async {
    final List<String> houseIdList = await _homeRepo.getHouseIdList();

    final List<HouseModel> houseList = [];
    for (final houseId in houseIdList) {
      try {
        final HouseModel houseEntity = await _homeRepo.getHouseModel(houseId);
        houseList.add(houseEntity);
      } on CustomException catch (e) {
        return Left(Failure(
          code: e.code,
          message: e.message,
        ));
      }
    }

    return Right(houseList);
  }

  Future<void> putHouseEntity(HouseModel houseEntity) async {
    await _homeRepo.putHouseModel(houseEntity);
  }
}
