import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../../core/widgets/base.dart';
import '../../camera_injector.dart';
import '../cubit/camera_cubit.dart';
import '../cubit/get_camera_cubit.dart';
import '../cubit/camera_controller_cubit.dart';
import '../widgets/preview_picture.dart';
import '../widgets/take_picture.dart';

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
          return WillPopScope(
            onWillPop: () {
              if (hasImage) {
                cameraCubit.retakePicture();
                setState(() {});
                return Future.value(false);
              }

              Navigator.pop(context);
              return Future.value(false);
            },
            child: BaseWithScaffold(
              title: hasImage ? "Preview" : "Take Picture",
              leftIcon: IconButton(
                icon: const Icon((Icons.arrow_back_ios_new)),
                onPressed: () {
                  if (hasImage) {
                    cameraCubit.retakePicture();
                    setState(() {});
                    return;
                  }

                  Navigator.pop(context);
                },
                splashColor: Colors.transparent,
                highlightColor: Colors.transparent,
                iconSize: 34,
              ),
              child: hasImage
                  ? const PreviewPictureWidget()
                  : const TakePictureWidget(),
            ),
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
