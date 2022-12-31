import 'package:get_it/get_it.dart';
import 'data/repositories/pet_details_repo_impl.dart';
import 'domain/repositories/pet_details_repo.dart';
import 'domain/usecases/update_pet_usecase.dart';
import 'presentations/cubit/is_edit_cubit.dart';
import 'presentations/cubit/update_pet_cubit.dart';

final petDetailsInjector = GetIt.instance;

void init() {
  //Repositories
  petDetailsInjector.registerLazySingleton<PetDetailsRepo>(
    () => PetDetailsRepoImpl(
      homeRepo: petDetailsInjector(),
      coreRepo: petDetailsInjector(),
    ),
  );

  // UseCases
  petDetailsInjector.registerLazySingleton<UpdatePetUseCase>(
      () => UpdatePetUseCase(petDetailsRepo: petDetailsInjector()));

  //Blocs
  petDetailsInjector.registerLazySingleton<UpdatePetCubit>(
    () => UpdatePetCubit(
      updatePetUseCase: petDetailsInjector(),
    ),
  );

  petDetailsInjector.registerLazySingleton<IsEditCubit>(() => IsEditCubit());
}
