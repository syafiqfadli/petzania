import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../core/domain/entities/pet_entity.dart';
import '../../../../core/services/dialog_service.dart';
import '../../../../core/util/colors.dart';
import '../../../../core/widgets/base.dart';
import '../../../../core/widgets/input_field.dart';
import '../../../camera/camera_injector.dart';
import '../../../camera/presentation/cubit/take_picture_cubit.dart';
import '../../../camera/presentation/pages/camera_page.dart';
import '../../../home/home_injector.dart';
import '../../../home/presentation/bloc/home_bloc.dart';
import '../../add_pet_injector.dart';
import '../cubit/add_pet_cubit.dart';
import '../cubit/change_color_cubit.dart';
import '../cubit/is_color_selected_cubit.dart';
import '../cubit/is_name_valid_cubit.dart';
import '../cubit/pick_color_cubit.dart';

class AddPetPage extends StatefulWidget {
  const AddPetPage({Key? key}) : super(key: key);

  @override
  State<AddPetPage> createState() => _AddPetPageState();
}

class _AddPetPageState extends State<AddPetPage> {
  final ChangeColorCubit changeColorCubit = ChangeColorCubit();
  final PickColorCubit pickColorCubit = PickColorCubit();
  final IsColorSelectedCubit isColorSelectedCubit = IsColorSelectedCubit();
  final IsNameValidCubit isNameValidCubit = IsNameValidCubit();
  final TakePictureCubit takePictureCubit = cameraInjector<TakePictureCubit>();
  final AddPetCubit addPetCubit = addPetInjector<AddPetCubit>();
  final HomeBloc homeBloc = homeInjector<HomeBloc>();

  final TextEditingController _nameController = TextEditingController();
  final _formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width;

    return MultiBlocProvider(
      providers: [
        BlocProvider(create: (context) => changeColorCubit),
        BlocProvider(create: (context) => pickColorCubit),
        BlocProvider(create: (context) => isColorSelectedCubit),
        BlocProvider(create: (context) => isNameValidCubit),
        BlocProvider.value(value: takePictureCubit),
        BlocProvider.value(value: addPetCubit),
        BlocProvider.value(value: homeBloc),
      ],
      child: BlocListener<AddPetCubit, AddPetState>(
        listener: (context, state) {
          if (state is AddPetSuccessful) {
            _addPetResult(
              title: "Pet added successfuly!",
              icon: Icons.check,
              width: width,
            );
          }

          if (state is AddPetFailed) {
            _addPetResult(
              title: "Add pet failed.",
              icon: Icons.cancel,
              width: width,
            );
          }
        },
        child: WillPopScope(
          onWillPop: () {
            takePictureCubit.resetImage();
            Navigator.of(context).pop();
            return Future.value(false);
          },
          child: BaseWithScaffold(
            title: "Add Pet",
            leftIcon: IconButton(
              icon: const Icon((Icons.arrow_back_ios_new)),
              onPressed: () {
                takePictureCubit.resetImage();
                Navigator.of(context).pop();
              },
              splashColor: Colors.transparent,
              highlightColor: Colors.transparent,
              iconSize: 34,
            ),
            bottomWidget: BlocBuilder<IsNameValidCubit, bool>(
              builder: (context, isValid) {
                return ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    backgroundColor: AppColor.primaryColor,
                    fixedSize: Size(width, 60),
                  ),
                  onPressed: isValid ? _addPet : null,
                  child: const Text(
                    'Add Pet',
                    style: TextStyle(fontSize: 20),
                  ),
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
                      onTap: () async {
                        FocusManager.instance.primaryFocus?.unfocus();
                        await Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => const CameraPage(),
                          ),
                        );
                      },
                      child: BlocBuilder<TakePictureCubit, String?>(
                        builder: (context, image) {
                          if (image != null) {
                            return Stack(
                              children: [
                                Align(
                                  alignment: Alignment.center,
                                  child: CircleAvatar(
                                    radius: 80,
                                    backgroundImage: FileImage(
                                      File(image),
                                    ),
                                    backgroundColor: Colors.transparent,
                                  ),
                                ),
                              ],
                            );
                          }
                          return CircleAvatar(
                            radius: 80,
                            backgroundColor: Colors.white,
                            foregroundColor: AppColor.defaultColor,
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: const [
                                Icon(
                                  Icons.camera_alt,
                                  size: 30,
                                ),
                                Text("Add image")
                              ],
                            ),
                          );
                        },
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
                          Row(
                            children: [
                              const Text(
                                "Name",
                                style: TextStyle(fontSize: 20),
                              ),
                              const Spacer(),
                              SizedBox(
                                width: width * 0.6,
                                child: InputFieldWidget(
                                  textController: _nameController,
                                  inputType: TextInputType.text,
                                  hint: "Enter pet name...",
                                  isObscure: false,
                                  onChanged: (String? value) {
                                    isNameValidCubit.validate(value);
                                  },
                                ),
                              )
                            ],
                          ),
                          const SizedBox(height: 20),
                          Row(
                            children: [
                              const Text(
                                "Color",
                                style: TextStyle(fontSize: 20),
                              ),
                              const Spacer(),
                              BlocBuilder<IsColorSelectedCubit, bool>(
                                builder: (context, isSelected) {
                                  if (!isSelected) {
                                    return ElevatedButton(
                                      style: ElevatedButton.styleFrom(
                                        backgroundColor: AppColor.primaryColor,
                                        fixedSize: const Size(190, 40),
                                      ),
                                      onPressed: () => _showColorPicker(width),
                                      child: const Text(
                                        "Choose Color",
                                        style: TextStyle(fontSize: 20),
                                      ),
                                    );
                                  }
                                  return Row(
                                    children: [
                                      BlocBuilder<PickColorCubit, Color>(
                                        builder: (context, color) {
                                          return Container(
                                            width: 40,
                                            height: 40,
                                            decoration: BoxDecoration(
                                              color: color,
                                              borderRadius:
                                                  const BorderRadius.all(
                                                Radius.circular(20),
                                              ),
                                            ),
                                          );
                                        },
                                      ),
                                      const SizedBox(
                                        width: 10,
                                      ),
                                      ElevatedButton(
                                        style: ElevatedButton.styleFrom(
                                          backgroundColor:
                                              AppColor.primaryColor,
                                          fixedSize: const Size(120, 40),
                                        ),
                                        onPressed: () =>
                                            _showColorPicker(width),
                                        child: const Text(
                                          "Change",
                                          style: TextStyle(fontSize: 20),
                                        ),
                                      )
                                    ],
                                  );
                                },
                              )
                            ],
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

  void _addPet() {
    final pet = PetEntity(
      image: takePictureCubit.state,
      name: _nameController.text,
      breed: "Not Available",
      age: 0,
      colorValue: pickColorCubit.pickedColor.value,
    );

    addPetCubit.addPet(pet: pet);
  }

  void _changeColor(Color color) {
    changeColorCubit.changeColor(color);
  }

  void _selectColor() {
    isColorSelectedCubit.isSelected(true);
    pickColorCubit.pickColor(changeColorCubit.changedColor);
    Navigator.of(context).pop();
  }

  void _showColorPicker(double width) {
    FocusManager.instance.primaryFocus?.unfocus();
    DialogService.showColorPicker(
      changeColor: _changeColor,
      selectColor: _selectColor,
      width: width,
      context: context,
    );
  }

  void _addPetResult({
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
    takePictureCubit.resetImage();
    _nameController.clear();
    isNameValidCubit.validate(_nameController.text);
    isColorSelectedCubit.isSelected(false);
  }
}
