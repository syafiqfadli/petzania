import 'dart:io';

import 'package:animated_widgets/widgets/rotation_animated.dart';
import 'package:animated_widgets/widgets/shake_animated_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../core/domain/entities/pet_entity.dart';
import '../../../../core/util/colors.dart';
import '../../../pet_details/presentations/pages/pet_details_page.dart';
import '../../home_injector.dart';
import '../cubit/delete_pet_cubit.dart';
import '../cubit/is_selected_cubit.dart';

class PetCard extends StatefulWidget {
  final List petList;
  final PetEntity pet;
  final int index;

  const PetCard({
    Key? key,
    required this.pet,
    required this.index,
    required this.petList,
  }) : super(key: key);

  @override
  State<PetCard> createState() => _PetCardState();
}

class _PetCardState extends State<PetCard> {
  final DeletePetCubit deletePetCubit = homeInjector<DeletePetCubit>();
  final IsSelectedCubit isSelectedCubit = homeInjector<IsSelectedCubit>();

  @override
  Widget build(BuildContext context) {
    List petList = widget.petList;
    PetEntity pet = widget.pet;
    int index = widget.index;

    return BlocProvider.value(
      value: deletePetCubit,
      child: Padding(
        padding: const EdgeInsets.all(5),
        child: BlocBuilder<IsSelectedCubit, bool>(
          builder: (context, isSelected) {
            return ShakeAnimatedWidget(
              enabled: isSelected,
              shakeAngle: Rotation.deg(z: 2),
              child: InkWell(
                highlightColor: Colors.transparent,
                splashColor: Colors.transparent,
                onLongPress: isSelected
                    ? null
                    : () {
                        isSelectedCubit.isSelected();
                      },
                onTap: isSelected
                    ? null
                    : () async {
                        await Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => PetDetailsPage(
                              pet: pet,
                              index: index,
                            ),
                          ),
                        );
                      },
                child: Stack(
                  alignment: Alignment.bottomCenter,
                  children: [
                    Card(
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(10),
                      ),
                      elevation: 2,
                      color: Color(pet.colorValue),
                      child: Padding(
                        padding: const EdgeInsets.symmetric(
                          horizontal: 15,
                          vertical: 15,
                        ),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.start,
                          children: [
                            pet.image == null
                                ? CircleAvatar(
                                    radius: 30,
                                    backgroundColor: Colors.white,
                                    foregroundColor: AppColor.defaultColor,
                                    child: Center(
                                      child: Text(
                                        pet.name[0].toUpperCase(),
                                        style: const TextStyle(fontSize: 25),
                                      ),
                                    ),
                                  )
                                : CircleAvatar(
                                    radius: 30,
                                    backgroundImage: FileImage(
                                      File(pet.image!),
                                    ),
                                  ),
                            const SizedBox(width: 10),
                            Flexible(
                              child: Text(
                                pet.name,
                                overflow: TextOverflow.ellipsis,
                                style: const TextStyle(
                                  color: Colors.white,
                                  fontSize: 20,
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                    isSelected
                        ? Positioned(
                            top: 0,
                            right: 0,
                            child: Container(
                              width: 40,
                              height: 40,
                              decoration: const BoxDecoration(
                                shape: BoxShape.circle,
                                color: Colors.red,
                              ),
                              child: IconButton(
                                onPressed: () async {
                                  if (petList.length == 1) {
                                    isSelectedCubit.isSelected();
                                  }
                                  await deletePetCubit.deletePet(index);
                                },
                                icon: const Icon(Icons.close),
                              ),
                            ),
                          )
                        : const SizedBox.shrink(),
                  ],
                ),
              ),
            );
          },
        ),
      ),
    );
  }
}
