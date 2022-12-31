import 'package:flutter/material.dart';

class InputFieldWidget extends StatelessWidget {
  final bool? enabled;
  final TextEditingController textController;
  final TextInputType inputType;
  final bool isObscure;
  final String? label;
  final String? hint;
  final String? Function(String?)? validate;
  final void Function(String?)? onChanged;
  final void Function(String?)? onFieldSubmitted;

  const InputFieldWidget({
    Key? key,
    this.enabled = true,
    required this.textController,
    required this.inputType,
    required this.isObscure,
    this.label,
    this.hint,
    this.validate,
    this.onChanged,
    this.onFieldSubmitted,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      enabled: enabled,
      controller: textController,
      obscureText: isObscure,
      autovalidateMode: AutovalidateMode.onUserInteraction,
      onFieldSubmitted: onFieldSubmitted,
      onChanged: onChanged,
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
        contentPadding: const EdgeInsets.all(10),
      ),
    );
  }
}
