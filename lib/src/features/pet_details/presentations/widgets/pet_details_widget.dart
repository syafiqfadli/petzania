import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../core/widgets/input_field.dart';
import '../cubit/is_edit_cubit.dart';

class PetDetailsWidget extends StatefulWidget {
  final TextEditingController textController;
  final TextInputType textType;
  final String title;
  final String hint;
  const PetDetailsWidget({
    Key? key,
    required this.textController,
    required this.textType,
    required this.title,
    required this.hint,
  }) : super(key: key);

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
                    textController: widget.textController,
                    inputType: widget.textType,
                    hint: widget.hint,
                    isObscure: false,
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
