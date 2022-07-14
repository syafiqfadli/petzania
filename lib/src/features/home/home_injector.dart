import 'package:get_it/get_it.dart';
import 'package:pet_care_flutter_app/src/features/home/data/repositories/home_repo_impl.dart';
import 'package:pet_care_flutter_app/src/features/home/domain/repositories/home_repo.dart';
import 'package:pet_care_flutter_app/src/features/home/domain/usecases/delete_pet_usecase.dart';
import 'package:pet_care_flutter_app/src/features/home/domain/usecases/get_pet_list_usecase.dart';
import 'package:pet_care_flutter_app/src/features/home/presentation/bloc/home_bloc.dart';
import 'package:pet_care_flutter_app/src/features/home/presentation/cubit/delete_pet_cubit.dart';
import 'package:pet_care_flutter_app/src/features/home/presentation/cubit/get_pet_list_cubit.dart';
import 'package:pet_care_flutter_app/src/features/home/presentation/cubit/is_selected_cubit.dart';
import 'package:pet_care_flutter_app/src/features/home/presentation/cubit/refresh_home_cubit.dart';

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
}
