import 'package:camera/camera.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class GetImageCubit extends Cubit<String?> {
  GetImageCubit() : super(null);

  Future<void> getImage(CameraController? controller) async {
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
    } catch (error) {
      print(error.toString());
    }
  }

  void resetImage() {
    emit(null);
  }
}
