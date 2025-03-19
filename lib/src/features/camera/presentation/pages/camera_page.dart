import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:petzania/src/core/widgets/base.dart';
import 'package:petzania/src/features/camera/camera_injector.dart';
import 'package:petzania/src/features/camera/presentation/cubit/camera_controller_cubit.dart';
import 'package:petzania/src/features/camera/presentation/cubit/is_loading_cubit.dart';
import 'package:petzania/src/features/camera/presentation/cubit/take_picture_cubit.dart';
import 'package:petzania/src/features/camera/presentation/widgets/preview_picture.dart';
import 'package:petzania/src/features/camera/presentation/widgets/take_picture.dart';

class CameraPage extends StatefulWidget {
  const CameraPage({super.key});

  @override
  State<CameraPage> createState() => _CameraPageState();
}

class _CameraPageState extends State<CameraPage> {
  final IsLoadingCubit isLoadingCubit = IsLoadingCubit();
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
          return PopScope(
            onPopInvoked: (pop) {
              if (pop) {
                return;
              }

              _goBack(hasImage);
            },
            child: BaseWithScaffold(
              title: hasImage ? "Preview" : "Take Picture",
              prefixIcon: IconButton(
                icon: const Icon((Icons.arrow_back_ios_new)),
                onPressed: () => _goBack(hasImage),
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

  void _goBack(bool hasImage) {
    if (hasImage) {
      takePictureCubit.resetImage();
      setState(() {});
      return;
    }

    Navigator.pop(context);
  }

  void _loadCamera() async {
    await cameraControllerCubit.initializeController();
  }
}
