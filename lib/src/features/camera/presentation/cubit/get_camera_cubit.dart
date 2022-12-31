import 'package:camera/camera.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class GetCameraCubit extends Cubit<CameraDescription?> {
  GetCameraCubit() : super(null);

  Future<void> getCamera() async {
    final cameraList = await availableCameras();

    if (cameraList.isEmpty) {
      emit(null);
      return;
    }

    final camera = cameraList.first;

    emit(camera);
  }
}
