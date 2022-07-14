import 'package:camera/camera.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:pet_care_flutter_app/src/core/util/colors.dart';
import 'package:pet_care_flutter_app/src/core/widgets/base.dart';
import 'package:pet_care_flutter_app/src/features/camera/camera_injector.dart';
import 'package:pet_care_flutter_app/src/features/camera/presentation/cubit/get_camera_cubit.dart';
import 'package:pet_care_flutter_app/src/features/camera/presentation/cubit/get_image_cubit.dart';
import 'package:pet_care_flutter_app/src/features/camera/presentation/cubit/camera_controller_cubit.dart';

class TakePicturePage extends StatefulWidget {
  const TakePicturePage({Key? key}) : super(key: key);

  @override
  State<TakePicturePage> createState() => _TakePicturePageState();
}

class _TakePicturePageState extends State<TakePicturePage> {
  final GetCameraCubit cameraCubit = GetCameraCubit();
  final GetImageCubit getImageCubit = cameraInjector<GetImageCubit>();
  final CameraControllerCubit cameraControllerCubit = CameraControllerCubit();

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
    double width = MediaQuery.of(context).size.width;
    double height = MediaQuery.of(context).size.height;

    return MultiBlocProvider(
      providers: [
        BlocProvider(create: (context) => cameraCubit),
        BlocProvider(create: (context) => cameraControllerCubit),
        BlocProvider.value(value: getImageCubit),
      ],
      child: BaseWithScaffold(
        title: "Take Picture",
        hasRightIcon: false,
        icon: Icons.arrow_back_ios,
        iconPressed: () {
          Navigator.of(context).pop();
        },
        child: BlocBuilder<CameraControllerCubit, CameraController?>(
          builder: (context, controller) {
            return Expanded(
              child: Column(
                children: [
                  controller != null && controller.value.isInitialized
                      ? SizedBox(
                          height: height * 0.6,
                          child: Stack(
                            children: [
                              Align(
                                alignment: Alignment.center,
                                child: SizedBox(
                                  width: width,
                                  child: CameraPreview(controller),
                                ),
                              ),
                              Align(
                                alignment: Alignment.center,
                                child: Container(
                                  width: width,
                                  decoration: const BoxDecoration(
                                    color: Colors.black54,
                                  ),
                                ),
                              ),
                              Align(
                                alignment: Alignment.center,
                                child: Container(
                                  width: 200,
                                  height: 200,
                                  decoration: const BoxDecoration(
                                    shape: BoxShape.circle,
                                    color: Colors.white10,
                                  ),
                                ),
                              )
                            ],
                          ),
                        )
                      : SizedBox(
                          height: height * 0.6,
                          child: const Center(
                            child: Text(
                              "Camera Loading.....",
                              style: TextStyle(fontSize: 20),
                            ),
                          ),
                        ),
                  const Spacer(),
                  ElevatedButton(
                    onPressed: () async {
                      await getImageCubit.getImage(controller);
                    },
                    style: ElevatedButton.styleFrom(
                      shape: const CircleBorder(),
                      padding: const EdgeInsets.all(20),
                      primary: AppColor.primaryColor,
                    ),
                    child: const Icon(Icons.camera_alt),
                  ),
                  const SizedBox(height: 25),
                ],
              ),
            );
          },
        ),
      ),
    );
  }

  void _loadCamera() async {
    await cameraCubit.getCamera();
    final camera = cameraCubit.state;

    await cameraControllerCubit.initializeController(camera);
  }
}
