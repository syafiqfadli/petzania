import 'dart:io';

import "package:flutter/material.dart";
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../../core/domain/entities/pet_entity.dart';
import '../../../home/home_injector.dart';
import '../../../home/presentation/bloc/home_bloc.dart';
import '../cubit/is_edit_cubit.dart';
import '../cubit/update_pet_cubit.dart';

import '../../../../core/services/dialog_service.dart';
import '../../../../core/util/colors.dart';
import '../../../../core/widgets/base.dart';
import '../../pet_details_injector.dart';
import '../widgets/pet_details_widget.dart';

class PetDetailsPage extends StatefulWidget {
  final PetEntity pet;
  final int index;
  const PetDetailsPage({
    super.key,
    required this.pet,
    required this.index,
  });

  @override
  State<PetDetailsPage> createState() => _PetDetailsPageState();
}

class _PetDetailsPageState extends State<PetDetailsPage> {
  final UpdatePetCubit updatePetCubit = petDetailsInjector<UpdatePetCubit>();
  final IsEditCubit isEditCubit = petDetailsInjector<IsEditCubit>();
  final HomeBloc homeBloc = homeInjector<HomeBloc>();
  final TextEditingController _breedController = TextEditingController();
  final TextEditingController _ageController = TextEditingController();
  final _formKey = GlobalKey<FormState>();

  @override
  void initState() {
    super.initState();
    _breedController.text = widget.pet.breed!;
    _ageController.text = widget.pet.age!.toString();
  }

  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width;

    return WillPopScope(
      onWillPop: () {
        isEditCubit.reset();
        Navigator.of(context).pop();
        return Future.value(false);
      },
      child: MultiBlocProvider(
        providers: [
          BlocProvider.value(value: updatePetCubit),
          BlocProvider.value(value: isEditCubit),
        ],
        child: BlocListener<UpdatePetCubit, UpdatePetState>(
          listener: (context, state) {
            if (state is UpdatePetSuccessful) {
              _updatePetResult(
                title: "Saved Successfully!",
                icon: Icons.check,
                width: width,
              );
            }

            if (state is UpdatePetFailed) {
              _updatePetResult(
                title: "Saved Failed!",
                icon: Icons.cancel,
                width: width,
              );
            }
          },
          child: BaseWithScaffold(
            title: widget.pet.name.toUpperCase(),
            leftIcon: IconButton(
              icon: const Icon((Icons.arrow_back_ios_new)),
              onPressed: () {
                isEditCubit.reset();
                homeBloc.add(GetPetListEvent());
                Navigator.of(context).pop();
              },
              splashColor: Colors.transparent,
              highlightColor: Colors.transparent,
              iconSize: 34,
            ),
            rightIcon: BlocBuilder<IsEditCubit, bool>(
              builder: (context, isEdit) {
                if (isEdit) {
                  return IconButton(
                    icon: const Icon((Icons.check)),
                    onPressed: () {
                      isEditCubit.isEdit();
                      _saveDetails(pet: widget.pet, index: widget.index);
                    },
                    splashColor: Colors.transparent,
                    highlightColor: Colors.transparent,
                    iconSize: 34,
                  );
                }

                return IconButton(
                  icon: const Icon((Icons.edit)),
                  onPressed: () {
                    isEditCubit.isEdit();
                  },
                  splashColor: Colors.transparent,
                  highlightColor: Colors.transparent,
                  iconSize: 34,
                );
              },
            ),
            child: Expanded(
              child: ListView(
                physics: const BouncingScrollPhysics(),
                children: [
                  Container(
                    decoration: BoxDecoration(
                      shape: BoxShape.circle,
                      border: Border.all(
                        color: Colors.black,
                        width: 4.0,
                      ),
                    ),
                    child: InkWell(
                      splashColor: Colors.transparent,
                      highlightColor: Colors.transparent,
                      child: widget.pet.image != null
                          ? Stack(
                              children: [
                                Align(
                                  alignment: Alignment.center,
                                  child: CircleAvatar(
                                    radius: 80,
                                    backgroundImage: FileImage(
                                      File(widget.pet.image!),
                                    ),
                                    backgroundColor: Colors.transparent,
                                  ),
                                ),
                              ],
                            )
                          : const CircleAvatar(
                              radius: 80,
                              backgroundColor: Colors.white,
                              foregroundColor: AppColor.defaultColor,
                              child: Text("No Image"),
                            ),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.symmetric(
                      horizontal: 10,
                      vertical: 40,
                    ),
                    child: Form(
                      key: _formKey,
                      child: Column(
                        children: [
                          PetDetailsWidget(
                            title: "Age",
                            hint: "Enter pet age...",
                            textType: TextInputType.number,
                            textController: _ageController,
                          ),
                          PetDetailsWidget(
                            title: "Breed",
                            hint: "Enter pet breed...",
                            textType: TextInputType.text,
                            textController: _breedController,
                          ),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  Future<void> _saveDetails({
    required PetEntity pet,
    required int index,
  }) async {
    await updatePetCubit.updateDetails(
      index: index,
      name: pet.name,
      breed: _breedController.text,
      image: pet.image!,
      age: int.parse(_ageController.text),
      colorValue: pet.colorValue,
    );
  }

  void _updatePetResult({
    required String title,
    required IconData icon,
    required double width,
  }) async {
    await DialogService.showResult(
      title: title,
      icon: icon,
      width: width,
      context: context,
    );
    homeBloc.add(GetPetListEvent());
  }
}
