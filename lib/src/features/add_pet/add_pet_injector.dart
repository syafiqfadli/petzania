import 'package:get_it/get_it.dart';

import 'data/repositories/add_pet_repo_impl.dart';
import 'domain/repositories/add_pet_repo.dart';
import 'domain/usecases/add_pet_usecase.dart';
import 'presentation/cubit/add_pet_cubit.dart';

final addPetInjector = GetIt.instance;

void init() {
  //Repositories
  addPetInjector.registerLazySingleton<AddPetRepo>(() => AddPetRepoImpl(
        coreRepo: addPetInjector(),
        homeRepo: addPetInjector(),
      ));

  // UseCases
  addPetInjector.registerLazySingleton<AddPetUseCase>(
      () => AddPetUseCase(addPetRepo: addPetInjector()));

  //Blocs
  addPetInjector.registerLazySingleton<AddPetCubit>(() => AddPetCubit(
        addPetUseCase: addPetInjector(),
      ));
}
