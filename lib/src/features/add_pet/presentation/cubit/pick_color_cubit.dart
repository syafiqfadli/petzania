import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:pet_care_flutter_app/src/core/util/colors.dart';

class PickColorCubit extends Cubit<Color> {
  PickColorCubit() : super(AppColor.defaultColor);

  Color pickedColor = AppColor.defaultColor;

  void pickColor(Color color) {
    pickedColor = color;
    emit(pickedColor);
  }
}
