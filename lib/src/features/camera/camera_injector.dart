import 'package:get_it/get_it.dart';
import 'package:pet_care_flutter_app/src/features/camera/presentation/cubit/camera_cubit.dart';
import 'package:pet_care_flutter_app/src/features/camera/presentation/cubit/get_image_cubit.dart';

final cameraInjector = GetIt.instance;

void init() {
  //Blocs
  cameraInjector.registerLazySingleton<CameraCubit>(() => CameraCubit());

  cameraInjector.registerLazySingleton<GetImageCubit>(() => GetImageCubit());
}
