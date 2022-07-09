import 'package:get_it/get_it.dart';
import 'package:get_storage/get_storage.dart';
import 'package:pet_care_flutter_app/src/core/data/data_sources/local_datasource.dart';
import 'package:pet_care_flutter_app/src/core/data/repositories/core_repo_impl.dart';
import 'package:pet_care_flutter_app/src/core/domain/repositories/core_repo.dart';

final coreInjector = GetIt.instance;

void init() {
  //DataSources
  coreInjector.registerLazySingleton<LocalDataSource>(
      () => LocalDataSourceImpl(storage: GetStorage()));

  //Repositories
  coreInjector.registerLazySingleton<CoreRepo>(
      () => CoreRepoImpl(localDataSource: coreInjector()));
}
