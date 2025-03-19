import 'package:flutter/material.dart';

class InputFieldWidget extends StatelessWidget {
  final bool? enabled;
  final Color? textColor;
  final FocusNode? focusNode;
  final TextEditingController textController;
  final TextInputType inputType;
  final bool isObscure;
  final String? label;
  final String? hint;
  final String? Function(String?)? validate;
  final void Function(String?)? onChanged;
  final void Function(String?)? onFieldSubmitted;

  const InputFieldWidget({
    super.key,
    this.enabled = true,
    this.textColor = Colors.black,
    this.focusNode,
    required this.textController,
    required this.inputType,
    required this.isObscure,
    this.label,
    this.hint,
    this.validate,
    this.onChanged,
    this.onFieldSubmitted,
  });

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      enabled: enabled,
      focusNode: focusNode,
      controller: textController,
      obscureText: isObscure,
      autovalidateMode: AutovalidateMode.onUserInteraction,
      onFieldSubmitted: onFieldSubmitted,
      onChanged: onChanged,
      validator: validate,
      keyboardType: inputType,
      style: TextStyle(fontSize: 20, color: textColor),
      decoration: InputDecoration(
        fillColor: Colors.white,
        filled: true,
        border: const OutlineInputBorder(
          borderRadius: BorderRadius.all(Radius.circular(10)),
        ),
        labelText: label,
        hintText: hint,
        errorText: null,
        contentPadding: const EdgeInsets.all(10),
      ),
    );
  }
}
