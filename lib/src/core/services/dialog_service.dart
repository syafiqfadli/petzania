import 'package:flutter/material.dart';
import 'package:flutter_colorpicker/flutter_colorpicker.dart';
import 'package:petzania/src/core/util/colors.dart';

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

  static Future showDeleteCancel<T>({
    required Function() onDelete,
    required BuildContext context,
  }) async {
    return showDialog(
      context: context,
      builder: (_) => AlertDialog(
        title: const Column(
          children: [
            Icon(
              Icons.delete,
              size: 45,
            ),
            SizedBox(height: 10),
            Text("Are you sure?"),
          ],
        ),
        actions: [
          Row(
            children: [
              Expanded(
                child: ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    backgroundColor: AppColor.primaryColor,
                  ),
                  onPressed: () {
                    Navigator.of(context).pop();
                  },
                  child: const Text('Cancel'),
                ),
              ),
              const SizedBox(width: 10),
              Expanded(
                child: ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.red,
                  ),
                  onPressed: () {
                    onDelete();
                    Navigator.pop(context);
                  },
                  child: const Text('Delete'),
                ),
              ),
            ],
          )
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
