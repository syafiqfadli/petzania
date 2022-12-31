import 'package:flutter/material.dart';
import 'package:flutter_colorpicker/flutter_colorpicker.dart';

import '../util/colors.dart';

class DialogService {
  static Future showResult<T>({
    required String title,
    required IconData icon,
    required double width,
    required BuildContext context,
  }) async {
    return showDialog(
      context: context,
      builder: (_) => AlertDialog(
        title: Column(
          children: [
            Icon(
              icon,
              size: 45,
            ),
            const SizedBox(height: 10),
            Text(title),
          ],
        ),
        actions: [
          SizedBox(
            width: width,
            child: ElevatedButton(
              style: ElevatedButton.styleFrom(
                backgroundColor: AppColor.primaryColor,
              ),
              onPressed: () {
                Navigator.of(context).pop();
              },
              child: const Text('Close'),
            ),
          ),
        ],
      ),
    );
  }

  static Future showColorPicker<T>({
    required void Function(Color) changeColor,
    required void Function() selectColor,
    required double width,
    required BuildContext context,
  }) async {
    return showDialog(
      context: context,
      builder: (_) => AlertDialog(
        title: const Text('Pick a color!'),
        content: SingleChildScrollView(
          child: BlockPicker(
            pickerColor: AppColor.defaultColor,
            onColorChanged: changeColor,
          ),
        ),
        actions: [
          SizedBox(
            width: width,
            child: ElevatedButton(
              style: ElevatedButton.styleFrom(
                backgroundColor: AppColor.primaryColor,
              ),
              onPressed: selectColor,
              child: const Text('Pick'),
            ),
          ),
        ],
      ),
    );
  }
}
