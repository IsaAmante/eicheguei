import 'package:common/common.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class CustomTextField extends StatelessWidget {
  const CustomTextField({
    Key? key,
    this.controller,
    this.hintText = '',
    this.prefixIcon,
    this.suffixIcon,
    this.onSuffixPressed,
    this.onChanged,
    this.obscured = false,
    this.validator,
    this.readOnly = false,
    this.inputformaters,
    this.keyboardType,
  }) : super(key: key);

  final TextEditingController? controller;
  final String hintText;
  final Icon? prefixIcon, suffixIcon;
  final void Function(String)? onChanged;
  final VoidCallback? onSuffixPressed;
  final String? Function(String?)? validator;
  final bool obscured;
  final bool readOnly;
  final List<TextInputFormatter>? inputformaters;
  final TextInputType? keyboardType;

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      readOnly: readOnly,
      style: TextStyle(
        decoration: TextDecoration.none,
        fontSize: 16.0,
        fontStyle: FontStyle.normal,
        color: readOnly ? ColorPalette.neutral300 : ColorPalette.neutral600,
      ),
      controller: controller,
      obscureText: obscured,
      obscuringCharacter: '*',
      cursorColor: ColorPalette.neutral400,
      decoration: InputDecoration(
        fillColor: ColorPalette.neutral0,
        filled: true,
        border: borderDecoration,
        enabledBorder: borderDecoration,
        disabledBorder: borderDecoration,
        focusedBorder: borderDecoration,
        errorBorder: errorBorderDecoration,
        focusedErrorBorder: errorBorderDecoration,
        labelText: hintText,
        labelStyle: TextStyle(
          decoration: TextDecoration.none,
          fontFamily: "Montserrat-Regular",
          fontSize: 16.0,
          fontStyle: FontStyle.normal,
          color: ColorPalette.neutral400,
        ),
        prefixIcon: prefixIcon,
        suffixIcon: suffixIcon != null
            ? IconButton(
                icon: suffixIcon!,
                color: ColorPalette.neutral400,
                onPressed: onSuffixPressed ?? () {},
              )
            : null,
      ),
      onChanged: onChanged,
      validator: validator,
      inputFormatters: inputformaters,
      keyboardType: keyboardType,
    );
  }

  InputBorder get borderDecoration => OutlineInputBorder(
        borderSide: BorderSide(color: ColorPalette.neutral400),
        borderRadius: const BorderRadius.all(Radius.circular(8.0)),
      );

  InputBorder get errorBorderDecoration => OutlineInputBorder(
        borderSide: BorderSide(color: ColorPalette.error),
        borderRadius: const BorderRadius.all(Radius.circular(8.0)),
      );
}
