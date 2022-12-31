import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../core/domain/entities/pet_entity.dart';
import '../../../../core/util/colors.dart';
import '../../../../core/widgets/refresh.dart';
import '../../home_injector.dart';
import '../cubit/get_pet_list_cubit.dart';
import '../cubit/is_selected_cubit.dart';
import '../cubit/refresh_home_cubit.dart';
import 'pet_card.dart';

class HasPet extends StatefulWidget {
  const HasPet({Key? key}) : super(key: key);

  @override
  State<HasPet> createState() => _HasPetState();
}

class _HasPetState extends State<HasPet> {
  final IsSelectedCubit isSelectedCubit = homeInjector<IsSelectedCubit>();

  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width;

    return BlocBuilder<IsSelectedCubit, bool>(
      builder: (context, isSelected) {
        return Expanded(
          child: CustomRefresh(
            predicate: isSelected ? (_) => false : (_) => true,
            onRefresh: _refresh,
            child: Stack(
              children: [
                Align(
                  alignment: Alignment.topCenter,
                  child: BlocBuilder<GetPetListCubit, List<PetEntity>>(
                    builder: (context, petList) {
                      return GridView.builder(
                        physics: const BouncingScrollPhysics(
                          parent: AlwaysScrollableScrollPhysics(),
                        ),
                        itemCount: petList.length,
                        gridDelegate:
                            const SliverGridDelegateWithFixedCrossAxisCount(
                          crossAxisCount: 2,
                          mainAxisExtent: 115,
                        ),
                        itemBuilder: (context, index) => PetCard(
                          petList: petList,
                          pet: petList[index],
                          index: index,
                        ),
                      );
                    },
                  ),
                ),
                isSelected
                    ? Padding(
                        padding: const EdgeInsets.only(bottom: 25),
                        child: Align(
                          alignment: Alignment.bottomCenter,
                          child: ElevatedButton(
                            style: ElevatedButton.styleFrom(
                              backgroundColor: AppColor.primaryColor,
                              fixedSize: Size(width, 60),
                            ),
                            onPressed: () {
                              isSelectedCubit.isSelected();
                            },
                            child: const Text(
                              "Done",
                              style: TextStyle(fontSize: 20),
                            ),
                          ),
                        ),
                      )
                    : const SizedBox.shrink(),
              ],
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
