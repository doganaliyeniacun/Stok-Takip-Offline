import 'package:flutter/material.dart';
import 'package:get/get_utils/src/extensions/internacionalization.dart';

class CustomTextFormField1 extends StatelessWidget {
  CustomTextFormField1({
    Key? key,
    this.name = "",
    this.validator,
    this.onSaved,
    this.textEditingController,
    this.textInputType,
    this.prefixIcon,
    this.textInputAction,
  }) : super(key: key);

  final TextEditingController? textEditingController;

  final String name;
  final String? Function(String?)? validator;
  final TextInputType? textInputType;
  final IconData? prefixIcon;
  final TextInputAction? textInputAction;

  void Function(String?)? onSaved;

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      decoration: InputDecoration(
        border: const OutlineInputBorder(
          borderRadius: BorderRadius.all(Radius.circular(10)),
        ),
        hintText: name.tr,
        filled: true,
        contentPadding: const EdgeInsets.all(10),
        prefixIcon: prefixIcon != null ? Icon(prefixIcon) : null,
      ),
      keyboardType: textInputType,
      controller: textEditingController,
      validator: validator,
      onSaved: onSaved,
      textInputAction: textInputAction,
    );
  }
}
