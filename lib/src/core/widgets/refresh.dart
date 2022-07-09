import 'package:flutter/material.dart';
import 'package:pet_care_flutter_app/src/core/util/colors.dart';

class CustomRefresh extends StatelessWidget {
  final Future<void> Function() onRefresh;
  final Widget child;

  const CustomRefresh({
    Key? key,
    required this.onRefresh,
    required this.child,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return RefreshIndicator(
      backgroundColor: AppColor.primaryColor,
      color: AppColor.defaultColor,
      displacement: 1,
      onRefresh: onRefresh,
      child: child,
    );
  }
}
