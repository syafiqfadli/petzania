import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:pet_care_flutter_app/src/core/domain/entities/pet_entity.dart';
import 'package:pet_care_flutter_app/src/features/home/home_injector.dart';
import 'package:pet_care_flutter_app/src/features/home/presentation/cubit/delete_pet_cubit.dart';
import 'package:pet_care_flutter_app/src/features/home/presentation/cubit/show_delete_cubit.dart';

class PetCard extends StatefulWidget {
  final PetEntity pet;
  final int index;

  const PetCard({
    Key? key,
    required this.pet,
    required this.index,
  }) : super(key: key);

  @override
  State<PetCard> createState() => _PetCardState();
}

class _PetCardState extends State<PetCard> {
  final DeletePetCubit deletePetCubit = homeInjector<DeletePetCubit>();
  final ShowDeleteCubit showDeleteCubit = ShowDeleteCubit();

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider.value(value: deletePetCubit),
        BlocProvider.value(value: showDeleteCubit),
      ],
      child: Padding(
        padding: const EdgeInsets.all(5),
        child: BlocBuilder<ShowDeleteCubit, bool>(
          builder: (context, show) {
            if (show) {
              return InkWell(
                highlightColor: Colors.transparent,
                splashColor: Colors.transparent,
                onTap: () {
                  showDeleteCubit.showDelete();
                },
                child: Stack(
                  alignment: Alignment.bottomCenter,
                  children: [
                    Card(
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(10),
                      ),
                      elevation: 2,
                      color: Color(widget.pet.colorValue),
                      child: Padding(
                        padding: const EdgeInsets.symmetric(
                          horizontal: 15,
                          vertical: 15,
                        ),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.start,
                          children: [
                            const CircleAvatar(
                              radius: 30,
                              backgroundColor: Colors.white,
                            ),
                            const SizedBox(width: 10),
                            Flexible(
                              child: Text(
                                widget.pet.name,
                                overflow: TextOverflow.ellipsis,
                                maxLines: 1,
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
                    Positioned(
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
                            showDeleteCubit.showDelete();
                            await deletePetCubit.deletePet(widget.index);
                          },
                          icon: const Icon(Icons.close),
                        ),
                      ),
                    ),
                  ],
                ),
              );
            }

            return InkWell(
              highlightColor: Colors.transparent,
              splashColor: Colors.transparent,
              onLongPress: () {
                showDeleteCubit.showDelete();
              },
              onTap: () {
                print("Show ${widget.pet.name} details");
              },
              child: Stack(
                alignment: Alignment.bottomCenter,
                children: [
                  Card(
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(10),
                    ),
                    elevation: 2,
                    color: Color(widget.pet.colorValue),
                    child: Padding(
                      padding: const EdgeInsets.symmetric(
                        horizontal: 15,
                        vertical: 15,
                      ),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: [
                          const CircleAvatar(
                            radius: 30,
                            backgroundColor: Colors.white,
                          ),
                          const SizedBox(width: 10),
                          Flexible(
                            child: Text(
                              widget.pet.name,
                              overflow: TextOverflow.ellipsis,
                              maxLines: 1,
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
                ],
              ),
            );
          },
        ),
      ),
    );
  }
}
