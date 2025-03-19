import 'package:flutter/material.dart';
import 'package:petzania/src/core/util/colors.dart';

class CustomRefresh extends StatelessWidget {
  final Future<void> Function() onRefresh;
  final bool Function(ScrollNotification) predicate;

  final Widget child;

  const CustomRefresh({
    super.key,
    required this.onRefresh,
    required this.child,
    required this.predicate,
  });

  @override
  Widget build(BuildContext context) {
    return RefreshIndicator(
      backgroundColor: AppColor.primaryColor,
      color: AppColor.defaultColor,
      displacement: 1,
      notificationPredicate: predicate,
      onRefresh: onRefresh,
      child: child,
    );
  }
}
