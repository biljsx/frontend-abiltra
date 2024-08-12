import 'package:flutter/material.dart';
import 'package:gap/gap.dart';

class CommonTextField extends StatelessWidget {
  final String title;
  final String hintText;
  final bool readOnly;
  final int maxLines;
  final TextEditingController? controller;
  final Widget? suffixIcon;
  final FormFieldSetter<String>? onSaved;
  final FormFieldValidator<String>? validator;

  const CommonTextField({
    Key? key,
    required this.title,
    required this.hintText,
    this.readOnly = false,
    this.maxLines = 1,
    this.controller,
    this.suffixIcon,
    this.onSaved,
    this.validator,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(title),
        const Gap(5),
        TextFormField(
          controller: controller,
          readOnly: readOnly,
          maxLines: maxLines,
          onSaved: onSaved,
          validator: validator,
          decoration: InputDecoration(
            hintText: hintText,
            suffixIcon: suffixIcon,
          ),
        ),
      ],
    );
  }
}
