import 'package:get_it/get_it.dart';
import 'package:hive/hive.dart';
import 'package:image_picker/image_picker.dart';
import 'package:stuff_scout/core/services/id_service.dart';
import 'package:stuff_scout/core/services/image_picker_service.dart';
import 'package:stuff_scout/core/services/local_storage_service.dart';
import 'package:stuff_scout/features/container/data/repositories/container_repo.dart';
import 'package:stuff_scout/features/container/domain/container_usecases/container_usecase.dart';
import 'package:stuff_scout/features/home/data/repositories/home_repo.dart';
import 'package:stuff_scout/features/home/domain/usercases/home_usecase.dart';
import 'package:stuff_scout/features/house/data/repositories/house_repo.dart';
import 'package:stuff_scout/features/room/data/repositories/room_repo.dart';
import 'package:stuff_scout/features/room/domain/usecases/room_usecase.dart';
import 'package:stuff_scout/features/search/data/repositories/search_repo.dart';
import 'package:uuid/uuid.dart';

import 'features/house/domain/usecases/house_usecase.dart';
import 'features/search/domain/usecases/search_usecase.dart';

final GetIt sl = GetIt.instance;

Future<void> setUpServices() async {
  // External services
  sl.registerSingleton<Uuid>(const Uuid());
  sl.registerSingleton<HiveInterface>(Hive);
  sl.registerSingleton<ImagePicker>(ImagePicker());

  // Internal services
  sl.registerSingleton<IdService>(IdService());
  sl.registerSingleton<LocalStorageService>(LocalStorageService());
  final LocalStorageService localStorageService = sl<LocalStorageService>();
  await localStorageService.init();
  sl.registerSingleton<ImagePickerService>(ImagePickerService());

  // Repositories
  sl.registerSingleton<HomeRepo>(HomeRepo());
  sl.registerSingleton<HouseRepo>(HouseRepo());
  sl.registerSingleton<RoomRepo>(RoomRepo());
  sl.registerSingleton<ContainerRepo>(ContainerRepo());
  sl.registerSingleton<SearchRepo>(SearchRepo());

  // Usecases
  sl.registerSingleton<HomeUsecase>(HomeUsecase());
  sl.registerSingleton<HouseUsecase>(HouseUsecase());
  sl.registerSingleton<RoomUsecase>(RoomUsecase());
  sl.registerSingleton<ContainerUsecase>(ContainerUsecase());
  sl.registerSingleton<SearchUsecase>(SearchUsecase());
}