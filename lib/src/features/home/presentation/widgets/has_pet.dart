import 'package:flutter/material.dart';
import 'package:pet_care_flutter_app/src/features/home/presentation/widgets/pet_card.dart';

class HasPet extends StatelessWidget {
  const HasPet({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: GridView.builder(
        physics: const BouncingScrollPhysics(),
        itemCount: 5,
        gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: 2,
          mainAxisExtent: 115,
        ),
        itemBuilder: (context, index) => const PetCard(),
      ),
    );
  }
}
