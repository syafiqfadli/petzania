import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../../core/util/colors.dart';

class ChangeColorCubit extends Cubit<void> {
  ChangeColorCubit() : super(null);

  Color changedColor = AppColor.defaultColor;

  void changeColor(Color color) {
    changedColor = color;
  }
}
