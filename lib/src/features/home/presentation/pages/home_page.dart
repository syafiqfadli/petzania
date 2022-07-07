import 'package:flutter/material.dart';
import 'package:pet_care_flutter_app/src/core/widgets/base.dart';
import 'package:pet_care_flutter_app/src/features/home/presentation/widgets/has_pet.dart';
import 'package:pet_care_flutter_app/src/features/home/presentation/widgets/no_pet.dart';

class HomePage extends StatelessWidget {
  const HomePage({Key? key}) : super(key: key);

  final pets = const [];

  @override
  Widget build(BuildContext context) {
    return BaseWithScaffold(
      title: "My Pets",
      icon: Icons.menu,
      iconPressed: () {},
      hasRightIcon: true,
      child: pets.isNotEmpty ? const HasPet() : const NoPet(),
    );
  }
}
