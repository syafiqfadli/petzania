import 'package:flutter/material.dart';
import 'package:pet_care_flutter_app/src/core/util/colors.dart';

class NoPet extends StatelessWidget {
  const NoPet({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    double height = MediaQuery.of(context).size.height;

    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        SizedBox(height: height * 0.1),
        const Text(
          "You don't have any pet yet",
          style: TextStyle(fontSize: 20),
        ),
        const SizedBox(
          height: 35,
        ),
        ElevatedButton(
          style: ElevatedButton.styleFrom(
            primary: AppColor.primaryColor,
            fixedSize: const Size(190, 50),
          ),
          onPressed: () {},
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: const [
              Icon(Icons.add, size: 30),
              SizedBox(width: 10),
              Text(
                "Add Pet",
                style: TextStyle(fontSize: 20),
              ),
            ],
          ),
        )
      ],
    );
  }
}
