import 'package:get_it/get_it.dart';
import 'presentation/cubit/take_picture_cubit.dart';

final cameraInjector = GetIt.instance;

void init() {
  //Blocs
  cameraInjector
      .registerLazySingleton<TakePictureCubit>(() => TakePictureCubit());
}
