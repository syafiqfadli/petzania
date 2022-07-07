import 'package:flutter/material.dart';

class DialogService {
  static Future show<T>({
    required Widget dialog,
    required BuildContext context,
  }) async {
    return showDialog(
      context: context,
      builder: (_) => dialog,
    );
  }
}
