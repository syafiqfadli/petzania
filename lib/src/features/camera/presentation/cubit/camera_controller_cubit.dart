import 'package:camera/camera.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class CameraControllerCubit extends Cubit<CameraController?> {
  CameraControllerCubit() : super(null);

  Future<void> initializeController(CameraDescription? camera) async {
    CameraController? controller;

    if (camera != null) {
      controller = CameraController(camera, ResolutionPreset.max);
      await controller.initialize();
      controller.setFlashMode(FlashMode.off);
      emit(controller);
      return;
    }

    emit(null);
  }
}
