import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:petzania/src/features/camera/camera_injector.dart';
import '../../../../core/widgets/base.dart';
import '../cubit/get_camera_cubit.dart';
import '../cubit/camera_controller_cubit.dart';
import '../cubit/is_loading_cubit.dart';
import '../cubit/take_picture_cubit.dart';
import '../widgets/preview_picture.dart';
import '../widgets/take_picture.dart';

class CameraPage extends StatefulWidget {
  const CameraPage({Key? key}) : super(key: key);

  @override
  State<CameraPage> createState() => _CameraPageState();
}

class _CameraPageState extends State<CameraPage> {
  final IsLoadingCubit isLoadingCubit = IsLoadingCubit();
  final GetCameraCubit getCameraCubit = GetCameraCubit();
  final CameraControllerCubit cameraControllerCubit = CameraControllerCubit();
  final TakePictureCubit takePictureCubit = cameraInjector<TakePictureCubit>();

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
        BlocProvider(create: (context) => isLoadingCubit),
        BlocProvider(create: (context) => cameraControllerCubit),
        BlocProvider(create: (context) => getCameraCubit),
        BlocProvider.value(value: takePictureCubit),
      ],
      child: BlocSelector<TakePictureCubit, String?, bool>(
        selector: (image) {
          if (image != null) {
            return true;
          }

          return false;
        },
        builder: (context, hasImage) {
          if (hasImage) {
            isLoadingCubit.setLoading();
          }
          return WillPopScope(
            onWillPop: () {
              if (hasImage) {
                takePictureCubit.resetImage();
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
                    takePictureCubit.resetImage();
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
