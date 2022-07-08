import 'package:get_it/get_it.dart';
import 'package:get_storage/get_storage.dart';
import 'package:pet_care_flutter_app/src/core/data/data_sources/local_datasource.dart';

final coreInject = GetIt.instance;

void init() {
  coreInject.registerLazySingleton<LocalDataSource>(
      () => LocalDataSourceImpl(storage: GetStorage()));
}
