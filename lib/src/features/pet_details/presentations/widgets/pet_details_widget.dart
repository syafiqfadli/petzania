import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../core/widgets/input_field.dart';
import '../cubit/is_edit_cubit.dart';

class PetDetailsWidget extends StatefulWidget {
  final TextEditingController textController;
  final TextInputType textType;
  final String title;
  final String hint;
  final FocusNode? focusNode;
  final String? Function(String?)? validate;

  const PetDetailsWidget(
      {Key? key,
      required this.textController,
      required this.textType,
      required this.title,
      required this.hint,
      this.focusNode,
      this.validate})
      : super(key: key);

  @override
  State<PetDetailsWidget> createState() => _PetDetailsWidgetState();
}

class _PetDetailsWidgetState extends State<PetDetailsWidget> {
  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width;

    return Column(
      children: [
        Row(
          children: [
            Text(
              widget.title,
              style: const TextStyle(fontSize: 20),
            ),
            const Spacer(),
            SizedBox(
              width: width * 0.6,
              child: BlocBuilder<IsEditCubit, bool>(
                builder: (context, isEdit) {
                  return InputFieldWidget(
                    enabled: isEdit,
                    focusNode: widget.focusNode,
                    textController: widget.textController,
                    textColor: isEdit ? Colors.black : Colors.grey,
                    inputType: widget.textType,
                    hint: widget.hint,
                    isObscure: false,
                    validate: widget.validate,
                    onChanged: (String? value) {},
                  );
                },
              ),
            )
          ],
        ),
        const SizedBox(height: 20),
      ],
    );
  }
}
