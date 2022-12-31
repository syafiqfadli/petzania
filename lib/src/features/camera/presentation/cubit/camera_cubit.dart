import 'package:camera/camera.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../camera_injector.dart';
import 'get_image_cubit.dart';

part 'camera_state.dart';

class CameraCubit extends Cubit<CameraState> {
  final GetImageCubit getImageCubit = cameraInjector<GetImageCubit>();

  CameraCubit() : super(CameraInitial());

  Future<void> takePicture(CameraController? controller) async {
    await getImageCubit.getImage(controller);

    final image = getImageCubit.state;

    if (image != null) {
      emit(CameraHasImage());
      return;
    }

    emit(CameraInitial());
  }

  void retakePicture() {
    getImageCubit.resetImage();
    emit(CameraInitial());
  }

  void resetCamera() {
    emit(CameraInitial());
  }
}
