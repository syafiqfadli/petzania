import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../core/util/colors.dart';
import '../../camera_injector.dart';
import '../cubit/take_picture_cubit.dart';

class PreviewPictureWidget extends StatefulWidget {
  const PreviewPictureWidget({Key? key}) : super(key: key);

  @override
  State<PreviewPictureWidget> createState() => _PreviewPictureWidgetState();
}

class _PreviewPictureWidgetState extends State<PreviewPictureWidget> {
  final TakePictureCubit getImageCubit = cameraInjector<TakePictureCubit>();

  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width;

    return BlocProvider.value(
      value: getImageCubit,
      child: BlocBuilder<TakePictureCubit, String?>(
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
                      backgroundColor: AppColor.defaultColor,
                      fixedSize: Size(width, 60),
                    ),
                    onPressed: () {
                      context.read<TakePictureCubit>().resetImage();
                    },
                    child: const Text(
                      "Retake",
                      style: TextStyle(fontSize: 20),
                    ),
                  ),
                  const SizedBox(height: 20),
                  ElevatedButton(
                    style: ElevatedButton.styleFrom(
                      backgroundColor: AppColor.primaryColor,
                      fixedSize: Size(width, 60),
                    ),
                    onPressed: () {
                      Navigator.of(context).pop();
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
