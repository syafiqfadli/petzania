import 'package:flutter/material.dart';
import 'package:pet_care_flutter_app/src/core/usecases/navigator/navigator_push_usecase.dart';
import 'package:pet_care_flutter_app/src/core/util/colors.dart';
import 'package:pet_care_flutter_app/src/features/add_pet/presentation/pages/add_pet_page.dart';

class NoPet extends StatefulWidget {
  const NoPet({Key? key}) : super(key: key);

  @override
  State<NoPet> createState() => _NoPetState();
}

class _NoPetState extends State<NoPet> {
  final NavigatorPushUseCase navigatorPushUseCase = NavigatorPushUseCase();

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
          onPressed: () async {
            await navigatorPushUseCase(
              NavigatorPushParam(
                route: MaterialPageRoute(
                  builder: (context) => const AddPetPage(),
                ),
                context: context,
              ),
            );
          },
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
