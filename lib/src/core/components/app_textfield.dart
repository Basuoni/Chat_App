import 'package:flutter/material.dart';

import '../utils/app_colors.dart';

class AppTextField extends StatelessWidget {
  final String hint;
  final IconData? suffixIcon;
  final IconData? prefixIcon;
  final TextInputType? textInputType;
  final bool isPassword;
  final bool isMultiline;
  final VoidCallback? onPressedIcon;
  final ValueChanged<String>? onChanged;
  final FormFieldValidator<String>? validator;
  final TextEditingController txtController;

  const AppTextField({
    super.key,
    this.textInputType,
    this.onPressedIcon,
    this.validator,
    this.suffixIcon,
    this.onChanged,
    this.isPassword = false,
    this.isMultiline = false,
    required this.hint,
    required this.prefixIcon,
    required this.txtController,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.symmetric(vertical: 10, horizontal: 10),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(15),
        boxShadow: const [
          BoxShadow(
            color: Colors.black12,
            offset: Offset(
              0.0,
              3.0,
            ),
            blurRadius: 8.0,
            spreadRadius: 2.0,
          )
        ],
      ),
      child: TextFormField(
        onChanged: onChanged,
        minLines: isMultiline ? 5 : 1,
        maxLines: isMultiline ? 5 : 1,
        keyboardType: isMultiline
            ? TextInputType.multiline
            : (textInputType ?? TextInputType.text),
        obscureText: isPassword,
        validator: validator ??
            (it) {
              if (it?.isEmpty == true) return '$hint must not be empty';
              return null;
            },
        controller: txtController,
        style: const TextStyle(color: Colors.black),
        decoration: InputDecoration(
          border: OutlineInputBorder(
            borderSide: const BorderSide(width: 1, color: Colors.grey),
            borderRadius: BorderRadius.circular(10),
          ),
          enabledBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(10),
            borderSide: const BorderSide(width: 1, color: Colors.white),
          ),
          labelStyle: const TextStyle(color: Colors.black),
          prefixIcon: (prefixIcon != null
              ? Icon(
                  prefixIcon,
                  color: AppColors.primary,
                )
              : null),
          labelText: hint.toString(),
          suffixIcon: suffixIcon != null
              ? IconButton(
                  onPressed: onPressedIcon ?? () {},
                  icon: Icon(
                    suffixIcon,
                    color: Colors.black,
                  ))
              : null,
        ),
      ),
    );
  }
}
