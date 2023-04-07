import 'package:camera/camera.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'get_camera_cubit.dart';

class CameraControllerCubit extends Cubit<CameraController?> {
  CameraControllerCubit() : super(null);

  Future<void> initializeController() async {
    final GetCameraCubit getCameraCubit = GetCameraCubit();
    CameraController? controller;

    await getCameraCubit.getCamera();
    final camera = getCameraCubit.state;

    if (camera == null) {
      emit(null);
      return;
    }

    controller = CameraController(
      camera,
      ResolutionPreset.max,
      imageFormatGroup: ImageFormatGroup.yuv420,
    );

    await controller.initialize();
    controller.setFlashMode(FlashMode.off);
    emit(controller);
  }
}
