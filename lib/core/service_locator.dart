import 'package:get_it/get_it.dart';
import 'package:stuff_scout/core/services/id_service.dart';
import 'package:uuid/uuid.dart';

final GetIt sl = GetIt.instance;

void setUpServices() {
  // External services
  sl.registerSingleton<Uuid>(const Uuid());

  // Internal services
  sl.registerSingleton<IdService>(IdService());
}