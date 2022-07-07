import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:pet_care_flutter_app/src/core/util/colors.dart';

class SelectColorCubit extends Cubit<Color> {
  SelectColorCubit() : super(AppColor.color1);

  Color selectedColor = AppColor.color1;

  void selectColor(Color color) {
    selectedColor = color;
    emit(selectedColor);
  }
}
