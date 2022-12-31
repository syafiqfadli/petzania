import 'package:camera/camera.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class TakePictureCubit extends Cubit<String?> {
  TakePictureCubit() : super(null);

  Future<void> takePicture(CameraController? controller) async {
    try {
      XFile? image;

      if (controller == null) {
        emit(null);
        return;
      }

      if (controller.value.isInitialized) {
        image = await controller.takePicture();
      }

      if (image == null) {
        emit(null);
        return;
      }

      emit(image.path);
    } catch (_) {
      emit(null);
    }
  }

  void resetImage() {
    emit(null);
  }
}
