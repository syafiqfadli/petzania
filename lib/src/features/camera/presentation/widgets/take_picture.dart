import 'package:camera/camera.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:pet_care_flutter_app/src/core/util/colors.dart';
import 'package:pet_care_flutter_app/src/features/camera/presentation/cubit/camera_controller_cubit.dart';
import 'package:pet_care_flutter_app/src/features/camera/presentation/cubit/camera_cubit.dart';

class TakePictureWidget extends StatelessWidget {
  const TakePictureWidget({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width;
    double height = MediaQuery.of(context).size.height;

    return BlocBuilder<CameraControllerCubit, CameraController?>(
      builder: (context, controller) {
        return Expanded(
          child: Column(
            children: [
              controller != null && controller.value.isInitialized
                  ? SizedBox(
                      height: height * 0.6,
                      child: Stack(
                        children: [
                          SizedBox(
                            width: width,
                            child: CameraPreview(controller),
                          ),
                          ColorFiltered(
                            colorFilter: ColorFilter.mode(
                              Colors.black.withOpacity(0.5),
                              BlendMode.srcOut,
                            ),
                            child: Stack(
                              fit: StackFit.expand,
                              children: [
                                Align(
                                  alignment: Alignment.center,
                                  child: Container(
                                    width: width,
                                    decoration: const BoxDecoration(
                                      color: Colors.black,
                                      backgroundBlendMode: BlendMode.dstOut,
                                    ),
                                  ),
                                ),
                                Align(
                                  alignment: Alignment.center,
                                  child: Container(
                                    width: width,
                                    height: width,
                                    decoration: const BoxDecoration(
                                      shape: BoxShape.circle,
                                      color: Colors.white,
                                    ),
                                  ),
                                )
                              ],
                            ),
                          ),
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
                  await context.read<CameraCubit>().takePicture(controller);
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
    );
  }
}
