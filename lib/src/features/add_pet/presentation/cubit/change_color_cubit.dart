import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:pet_care_flutter_app/src/core/util/colors.dart';

class ChangeColorCubit extends Cubit<void> {
  ChangeColorCubit() : super(null);

  Color changedColor = AppColor.color1;

  void changeColor(Color color) {
    changedColor = color;
  }
}
