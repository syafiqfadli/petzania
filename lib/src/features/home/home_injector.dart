import 'package:get_it/get_it.dart';

import 'data/repositories/home_repo_impl.dart';
import 'domain/repositories/home_repo.dart';
import 'domain/usecases/delete_pet_usecase.dart';
import 'domain/usecases/get_pet_list_usecase.dart';
import 'domain/usecases/remove_all_pets_usecase.dart';
import 'presentation/bloc/home_bloc.dart';
import 'presentation/cubit/delete_pet_cubit.dart';
import 'presentation/cubit/get_pet_list_cubit.dart';
import 'presentation/cubit/is_selected_cubit.dart';
import 'presentation/cubit/refresh_home_cubit.dart';
import 'presentation/cubit/remove_all_pets_cubit.dart';

final homeInjector = GetIt.instance;

void init() {
  //Repositories
  homeInjector.registerLazySingleton<HomeRepo>(() => HomeRepoImpl(
        coreRepo: homeInjector(),
      ));

  // UseCases
  homeInjector.registerLazySingleton<GetPetListUseCase>(
      () => GetPetListUseCase(homeRepo: homeInjector()));

  homeInjector.registerLazySingleton<DeletePetUseCase>(
      () => DeletePetUseCase(homeRepo: homeInjector()));

  homeInjector.registerLazySingleton<RemoveAllPetsUseCase>(
      () => RemoveAllPetsUseCase(homeRepo: homeInjector()));

  //Blocs
  homeInjector.registerLazySingleton<GetPetListCubit>(() => GetPetListCubit(
        getPetListUseCase: homeInjector(),
      ));

  homeInjector.registerLazySingleton<DeletePetCubit>(() => DeletePetCubit(
        homeBloc: homeInjector(),
        deletePetUseCase: homeInjector(),
      ));

  homeInjector.registerLazySingleton<HomeBloc>(() => HomeBloc(
        getPetListCubit: homeInjector(),
      ));

  homeInjector.registerLazySingleton<RefreshHomeCubit>(
      () => RefreshHomeCubit(homeBloc: homeInjector()));

  homeInjector.registerLazySingleton<IsSelectedCubit>(() => IsSelectedCubit());

  homeInjector.registerLazySingleton<RemoveAllPetsCubit>(
    () => RemoveAllPetsCubit(
      removeAllPetsUseCase: homeInjector(),
      homeBloc: homeInjector(),
    ),
  );
}
