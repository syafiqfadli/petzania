import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_colorpicker/flutter_colorpicker.dart';
import 'package:pet_care_flutter_app/src/core/services/dialog_service.dart';
import 'package:pet_care_flutter_app/src/core/util/colors.dart';
import 'package:pet_care_flutter_app/src/core/widgets/base.dart';
import 'package:pet_care_flutter_app/src/core/widgets/input_field.dart';
import 'package:pet_care_flutter_app/src/features/add_pet/presentation/cubit/change_color_cubit.dart';
import 'package:pet_care_flutter_app/src/features/add_pet/presentation/cubit/is_color_selected_cubit.dart';
import 'package:pet_care_flutter_app/src/features/add_pet/presentation/cubit/select_color_cubit.dart';

class AddPetPage extends StatefulWidget {
  const AddPetPage({Key? key}) : super(key: key);

  @override
  State<AddPetPage> createState() => _AddPetPageState();
}

class _AddPetPageState extends State<AddPetPage> {
  final ChangeColorCubit changeColorCubit = ChangeColorCubit();
  final SelectColorCubit selectColorCubit = SelectColorCubit();
  final IsColorSelectedCubit isColorSelectedCubit = IsColorSelectedCubit();

  final TextEditingController _nameController = TextEditingController();
  final _formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width;

    return MultiBlocProvider(
      providers: [
        BlocProvider(
          create: (context) => changeColorCubit,
        ),
        BlocProvider(
          create: (context) => selectColorCubit,
        ),
        BlocProvider(
          create: (context) => isColorSelectedCubit,
        ),
      ],
      child: BaseWithScaffold(
        title: "Add Pet",
        hasRightIcon: false,
        icon: Icons.arrow_back_ios_new,
        iconPressed: () {
          Navigator.of(context).pop();
        },
        child: Column(
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
              padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 40),
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
                        const SizedBox(width: 15),
                        SizedBox(
                          width: width * 0.6,
                          child: InputFieldWidget(
                            textController: _nameController,
                            inputType: TextInputType.text,
                            isObscure: false,
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
                            return !isSelected
                                ? ElevatedButton(
                                    style: ElevatedButton.styleFrom(
                                      primary: AppColor.primaryColor,
                                      fixedSize: const Size(190, 40),
                                    ),
                                    onPressed: _showColorPicker,
                                    child: const Text(
                                      "Choose Color",
                                      style: TextStyle(fontSize: 20),
                                    ),
                                  )
                                : Row(
                                    children: [
                                      BlocBuilder<SelectColorCubit, Color>(
                                        builder: (context, color) {
                                          return Container(
                                            width: 40,
                                            height: 40,
                                            color: color,
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
                    )
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  void _changeColor(Color color) {
    changeColorCubit.changeColor(color);
  }

  void _selectColor() {
    isColorSelectedCubit.isSelected();
    selectColorCubit.selectColor(changeColorCubit.changedColor);
    Navigator.of(context).pop();
  }

  

  void _showColorPicker() {
    DialogService.show(
      dialog: AlertDialog(
        title: const Text('Pick a color!'),
        content: SingleChildScrollView(
          child: BlockPicker(
            pickerColor: AppColor.color1,
            onColorChanged: _changeColor,
          ),
        ),
        actions: [
          ElevatedButton(
            onPressed: _selectColor,
            child: const Text('Select'),
          ),
        ],
      ),
      context: context,
    );
  }
}
