import 'package:get_it/get_it.dart';
import 'package:pet_care_flutter_app/src/features/add_pet/data/repositories/add_pet_repo_impl.dart';
import 'package:pet_care_flutter_app/src/features/add_pet/domain/repositories/add_pet_repo.dart';
import 'package:pet_care_flutter_app/src/features/add_pet/domain/usecases/add_pet_usecase.dart';
import 'package:pet_care_flutter_app/src/features/add_pet/presentation/cubit/add_pet_cubit.dart';

final addPetInjector = GetIt.instance;

void init() {
  //Repositories
  addPetInjector.registerLazySingleton<AddPetRepo>(() => AddPetRepoImpl(
        localDataSource: addPetInjector(),
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
