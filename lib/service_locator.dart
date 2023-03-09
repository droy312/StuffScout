import 'package:get_it/get_it.dart';
import 'package:hive/hive.dart';
import 'package:stuff_scout/core/services/id_service.dart';
import 'package:stuff_scout/core/services/local_storage_service.dart';
import 'package:stuff_scout/features/home/data/repositories/home_repo.dart';
import 'package:stuff_scout/features/home/domain/usercases/home_usecase.dart';
import 'package:stuff_scout/features/house/data/repositories/house_repo.dart';
import 'package:uuid/uuid.dart';

import 'features/house/domain/usecases/house_usecase.dart';

final GetIt sl = GetIt.instance;

Future<void> setUpServices() async {
  // External services
  sl.registerSingleton<Uuid>(const Uuid());
  sl.registerSingleton<HiveInterface>(Hive);

  // Internal services
  sl.registerSingleton<IdService>(IdService());
  sl.registerSingleton<LocalStorageService>(LocalStorageService());
  final LocalStorageService localStorageService = sl<LocalStorageService>();
  await localStorageService.init();

  // Repositories
  sl.registerSingleton<HomeRepo>(HomeRepo());
  sl.registerSingleton<HouseRepo>(HouseRepo());

  // Usecases
  sl.registerSingleton<HomeUsecase>(HomeUsecase());
  sl.registerSingleton<HouseUsecase>(HouseUsecase());
}