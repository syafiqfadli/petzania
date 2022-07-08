import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:pet_care_flutter_app/src/core/domain/entities/pet_list_entity.dart';
import 'package:pet_care_flutter_app/src/core/util/colors.dart';
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
    return BlocBuilder<GetPetListCubit, PetListEntity>(
      builder: (context, list) {
        return Expanded(
          child: RefreshIndicator(
            color: AppColor.primaryColor,
            onRefresh: _refresh,
            child: GridView.builder(
              physics: const BouncingScrollPhysics(
                parent: AlwaysScrollableScrollPhysics(),
              ),
              itemCount: list.petList.length,
              gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 2,
                mainAxisExtent: 115,
              ),
              itemBuilder: (context, index) =>
                  PetCard(pet: list.petList[index]),
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
