import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:pet_care_flutter_app/src/core/widgets/base.dart';
import 'package:pet_care_flutter_app/src/features/camera/camera_injector.dart';
import 'package:pet_care_flutter_app/src/features/camera/presentation/cubit/camera_cubit.dart';
import 'package:pet_care_flutter_app/src/features/camera/presentation/cubit/get_camera_cubit.dart';
import 'package:pet_care_flutter_app/src/features/camera/presentation/cubit/camera_controller_cubit.dart';
import 'package:pet_care_flutter_app/src/features/camera/presentation/widgets/preview_picture.dart';
import 'package:pet_care_flutter_app/src/features/camera/presentation/widgets/take_picture.dart';

class CameraPage extends StatefulWidget {
  const CameraPage({Key? key}) : super(key: key);

  @override
  State<CameraPage> createState() => _CameraPageState();
}

class _CameraPageState extends State<CameraPage> {
  final GetCameraCubit getCameraCubit = GetCameraCubit();
  final CameraControllerCubit cameraControllerCubit = CameraControllerCubit();
  final CameraCubit cameraCubit = cameraInjector<CameraCubit>();

  @override
  void initState() {
    super.initState();
    _loadCamera();
  }

  @override
  void dispose() {
    super.dispose();
    cameraControllerCubit.state!.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(create: (context) => getCameraCubit),
        BlocProvider(create: (context) => cameraControllerCubit),
        BlocProvider.value(value: cameraCubit),
      ],
      child: BlocSelector<CameraCubit, CameraState, bool>(
        selector: (state) {
          if (state is CameraHasImage) {
            return true;
          }

          return false;
        },
        builder: (context, hasImage) {
          return BaseWithScaffold(
            title: hasImage ? "Preview" : "Take Picture",
            hasRightIcon: false,
            icon: Icons.arrow_back_ios,
            iconPressed: hasImage
                ? cameraCubit.retakePicture
                : () => Navigator.of(context).pop(),
            child: hasImage
                ? const PreviewPictureWidget()
                : const TakePictureWidget(),
          );
        },
      ),
    );
  }

  void _loadCamera() async {
    await getCameraCubit.getCamera();
    final camera = getCameraCubit.state;

    await cameraControllerCubit.initializeController(camera);
  }
}
