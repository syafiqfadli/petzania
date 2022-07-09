import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:pet_care_flutter_app/src/core/domain/entities/pet_entity.dart';
import 'package:pet_care_flutter_app/src/core/widgets/refresh.dart';
import 'package:pet_care_flutter_app/src/features/home/presentation/cubit/get_pet_list_cubit.dart';
import 'package:pet_care_flutter_app/src/features/home/presentation/cubit/refresh_home_cubit.dart';
import 'package:pet_care_flutter_app/src/features/home/presentation/widgets/pet_card.dart';

class HasPet extends StatefulWidget {
  const HasPet({Key? key}) : super(key: key);

  @override
  State<HasPet> createState() => _HasPetState();
}

class _HasPetState extends State<HasPet> {
  @override
  Widget build(BuildContext context) {
    return BlocBuilder<GetPetListCubit, List<PetEntity>>(
      builder: (context, petList) {
        return Expanded(
          child: CustomRefresh(
            onRefresh: _refresh,
            child: GridView.builder(
              physics: const BouncingScrollPhysics(
                parent: AlwaysScrollableScrollPhysics(),
              ),
              itemCount: petList.length,
              gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 2,
                mainAxisExtent: 115,
              ),
              itemBuilder: (context, index) => PetCard(pet: petList[index]),
            ),
          ),
        );
      },
    );
  }

  Future<void> _refresh() async {
    await context.read<RefreshHomeCubit>().refresh();
  }
}
