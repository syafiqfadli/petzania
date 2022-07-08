import 'package:flutter/material.dart';

class InputFieldWidget extends StatelessWidget {
  final TextEditingController textController;
  final TextInputType inputType;
  final bool isObscure;
  final String? label;
  final String? hint;
  final String? error;
  final String? Function(String?)? validate;
  final String? Function(String?)? onChange;
  final void Function(String?)? onFieldSubmitted;

  const InputFieldWidget({
    Key? key,
    required this.textController,
    required this.inputType,
    required this.isObscure,
    this.label,
    this.hint,
    this.error,
    this.validate,
    this.onChange,
    this.onFieldSubmitted,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      controller: textController,
      obscureText: isObscure,
      autovalidateMode: AutovalidateMode.onUserInteraction,
      onFieldSubmitted: onFieldSubmitted,
      validator: validate,
      keyboardType: inputType,
      style: const TextStyle(fontSize: 20),
      decoration: InputDecoration(
        fillColor: Colors.white,
        filled: true,
        border: const OutlineInputBorder(
          borderRadius: BorderRadius.all(Radius.circular(10)),
        ),
        labelText: label,
        hintText: hint,
        errorText: error,
        contentPadding: const EdgeInsets.all(10),
      ),
    );
  }
}
