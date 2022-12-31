import 'package:flutter/material.dart';
import 'package:pet_care_flutter_app/src/core/util/colors.dart';
import 'package:pet_care_flutter_app/src/features/home/home_injector.dart';
import 'package:pet_care_flutter_app/src/features/home/presentation/cubit/remove_all_pets_cubit.dart';

class SideBarWidget extends StatefulWidget {
  const SideBarWidget({super.key});

  @override
  State<SideBarWidget> createState() => _SideBarWidgetState();
}

class _SideBarWidgetState extends State<SideBarWidget> {
  final RemoveAllPetsCubit removeAllPetsCubit =
      homeInjector<RemoveAllPetsCubit>();

  @override
  Widget build(BuildContext context) {
    double height = MediaQuery.of(context).size.height;

    return Drawer(
      child: ListView(
        padding: EdgeInsets.only(top: height * 0.1),
        children: [
          ListTile(
            leading: const Icon(Icons.delete),
            title: const Text('Remove All Pets'),
            onTap: () {
              removeAllPetsCubit.removeAllPets();
            },
          ),
          const Padding(
            padding: EdgeInsets.symmetric(horizontal: 10),
            child: Divider(color: AppColor.defaultColor, thickness: 1),
          ),
        ],
      ),
    );
  }
}
