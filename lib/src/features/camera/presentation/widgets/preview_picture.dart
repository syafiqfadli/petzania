import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:pet_care_flutter_app/src/core/util/colors.dart';
import 'package:pet_care_flutter_app/src/features/camera/camera_injector.dart';
import 'package:pet_care_flutter_app/src/features/camera/presentation/cubit/camera_cubit.dart';
import 'package:pet_care_flutter_app/src/features/camera/presentation/cubit/get_image_cubit.dart';

class PreviewPictureWidget extends StatefulWidget {
  const PreviewPictureWidget({Key? key}) : super(key: key);

  @override
  State<PreviewPictureWidget> createState() => _PreviewPictureWidgetState();
}

class _PreviewPictureWidgetState extends State<PreviewPictureWidget> {
  final GetImageCubit getImageCubit = cameraInjector<GetImageCubit>();

  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width;

    return BlocProvider.value(
      value: getImageCubit,
      child: BlocBuilder<GetImageCubit, String?>(
        builder: (context, image) {
          return Expanded(
            child: Padding(
              padding: const EdgeInsets.only(bottom: 50),
              child: Column(
                children: [
                  Container(
                    width: 240,
                    decoration: BoxDecoration(
                      shape: BoxShape.circle,
                      border: Border.all(
                        color: Colors.black,
                        width: 4.0,
                      ),
                    ),
                    child: image != null
                        ? CircleAvatar(
                            radius: 120,
                            backgroundImage: FileImage(
                              File(image),
                            ),
                          )
                        : const CircleAvatar(
                            radius: 120,
                            backgroundColor: Colors.white,
                            foregroundColor: AppColor.defaultColor,
                            child: Text("No Image"),
                          ),
                  ),
                  const Spacer(),
                  ElevatedButton(
                    style: ElevatedButton.styleFrom(
                      primary: AppColor.defaultColor,
                      fixedSize: Size(width, 60),
                    ),
                    onPressed: () {
                      context.read<CameraCubit>().retakePicture();
                    },
                    child: const Text(
                      "Retake",
                      style: TextStyle(fontSize: 20),
                    ),
                  ),
                  const SizedBox(height: 20),
                  ElevatedButton(
                    style: ElevatedButton.styleFrom(
                      primary: AppColor.primaryColor,
                      fixedSize: Size(width, 60),
                    ),
                    onPressed: () {
                      Navigator.of(context).pop();
                      context.read<CameraCubit>().resetCamera();
                    },
                    child: const Text(
                      "Confirm",
                      style: TextStyle(fontSize: 20),
                    ),
                  ),
                ],
              ),
            ),
          );
        },
      ),
    );
  }
}
