import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_colorpicker/flutter_colorpicker.dart';
import 'package:pet_care_flutter_app/src/core/domain/entities/pet_entity.dart';
import 'package:pet_care_flutter_app/src/core/services/dialog_service.dart';
import 'package:pet_care_flutter_app/src/core/util/colors.dart';
import 'package:pet_care_flutter_app/src/core/widgets/base.dart';
import 'package:pet_care_flutter_app/src/core/widgets/input_field.dart';
import 'package:pet_care_flutter_app/src/features/add_pet/add_pet_injector.dart';
import 'package:pet_care_flutter_app/src/features/add_pet/presentation/cubit/add_pet_cubit.dart';
import 'package:pet_care_flutter_app/src/features/add_pet/presentation/cubit/change_color_cubit.dart';
import 'package:pet_care_flutter_app/src/features/add_pet/presentation/cubit/is_color_selected_cubit.dart';
import 'package:pet_care_flutter_app/src/features/add_pet/presentation/cubit/pick_color_cubit.dart';

class AddPetPage extends StatefulWidget {
  const AddPetPage({Key? key}) : super(key: key);

  @override
  State<AddPetPage> createState() => _AddPetPageState();
}

class _AddPetPageState extends State<AddPetPage> {
  final ChangeColorCubit changeColorCubit = ChangeColorCubit();
  final PickColorCubit pickColorCubit = PickColorCubit();
  final IsColorSelectedCubit isColorSelectedCubit = IsColorSelectedCubit();
  late AddPetCubit addPetCubit;

  final TextEditingController _nameController = TextEditingController();
  final _form = GlobalKey<FormState>();

  @override
  void initState() {
    super.initState();
    addPetCubit = addPetInjector<AddPetCubit>();
  }

  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width;

    return MultiBlocProvider(
      providers: [
        BlocProvider(
          create: (context) => changeColorCubit,
        ),
        BlocProvider(
          create: (context) => pickColorCubit,
        ),
        BlocProvider(
          create: (context) => isColorSelectedCubit,
        ),
        BlocProvider(
          create: (context) => addPetCubit,
        ),
      ],
      child: BaseWithScaffold(
        title: "Add Pet",
        hasRightIcon: false,
        icon: Icons.arrow_back_ios_new,
        iconPressed: () {
          Navigator.of(context).pop();
        },
        bottomWidget: ElevatedButton(
          style: ElevatedButton.styleFrom(
            primary: AppColor.primaryColor,
            fixedSize: Size(width, 60),
          ),
          onPressed: _addPet,
          child: const Text(
            'Add Pet',
            style: TextStyle(fontSize: 20),
          ),
        ),
        child: Expanded(
          child: ListView(
            physics: const BouncingScrollPhysics(),
            children: [
              Container(
                width: 140,
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  border: Border.all(
                    color: Colors.black,
                    width: 4.0,
                  ),
                ),
                child: const CircleAvatar(
                  radius: 70,
                  backgroundColor: Colors.white,
                ),
              ),
              Padding(
                padding:
                    const EdgeInsets.symmetric(horizontal: 10, vertical: 40),
                child: Form(
                  key: _form,
                  child: Column(
                    children: [
                      Row(
                        children: [
                          const Text(
                            "Name",
                            style: TextStyle(fontSize: 20),
                          ),
                          const SizedBox(width: 15),
                          SizedBox(
                            width: width * 0.6,
                            child: InputFieldWidget(
                              textController: _nameController,
                              inputType: TextInputType.text,
                              isObscure: false,
                              validate: (String? value) {
                                if (value == null) {
                                  return "Please enter pet name";
                                }

                                return null;
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
                          const SizedBox(width: 15),
                          BlocBuilder<IsColorSelectedCubit, bool>(
                            builder: (context, isSelected) {
                              if (!isSelected) {
                                return ElevatedButton(
                                  style: ElevatedButton.styleFrom(
                                    primary: AppColor.primaryColor,
                                    fixedSize: const Size(190, 40),
                                  ),
                                  onPressed: _showColorPicker,
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
                                          borderRadius: const BorderRadius.all(
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
                                      primary: AppColor.primaryColor,
                                      fixedSize: const Size(120, 40),
                                    ),
                                    onPressed: _showColorPicker,
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
    );
  }

  void _addPet() {
    if (!_form.currentState!.validate()) {
      return;
    }

    final pet = PetEntity(
      name: _nameController.text,
      colorValue: pickColorCubit.pickedColor.value,
    );

    addPetCubit.addPet(pet: pet);
  }

  void _changeColor(Color color) {
    changeColorCubit.changeColor(color);
  }

  void _selectColor() {
    isColorSelectedCubit.isSelected();
    pickColorCubit.pickColor(changeColorCubit.changedColor);
    Navigator.of(context).pop();
  }

  void _showColorPicker() {
    FocusManager.instance.primaryFocus?.unfocus();
    DialogService.show(
      dialog: AlertDialog(
        title: const Text('Pick a color!'),
        content: SingleChildScrollView(
          child: BlockPicker(
            pickerColor: AppColor.defaultColor,
            onColorChanged: _changeColor,
          ),
        ),
        actions: [
          ElevatedButton(
            style: ElevatedButton.styleFrom(
              primary: AppColor.primaryColor,
            ),
            onPressed: _selectColor,
            child: const Text('Pick'),
          ),
        ],
      ),
      context: context,
    );
  }
}
