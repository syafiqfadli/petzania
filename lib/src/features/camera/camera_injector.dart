import 'package:get_it/get_it.dart';
import 'presentation/cubit/camera_cubit.dart';
import 'presentation/cubit/get_image_cubit.dart';

final cameraInjector = GetIt.instance;

void init() {
  //Blocs
  cameraInjector.registerLazySingleton<CameraCubit>(() => CameraCubit());

  cameraInjector.registerLazySingleton<GetImageCubit>(() => GetImageCubit());
}
