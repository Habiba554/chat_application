// ignore_for_file: must_be_immutable

import 'package:chat_app/constants/app_colors.dart';
import 'package:chat_app/constants/app_style.dart';
import 'package:flutter/material.dart';


class CustomFormTextField  extends StatefulWidget {
  final String hint;
  final TextEditingController controller;
  final IconData? suffix;
  final IconData? prefix;
  final String? Function(String?)? validator;
  final TextInputType keyboardType;
  CustomFormTextField({super.key, required this.hint,this.suffix,this.prefix,this.isObscureText = false, this.validator, required this.keyboardType, required this.controller, this.startNumber});
  late bool isObscureText;
  final String? startNumber;


  @override
  State<CustomFormTextField> createState() => _CustomFormTextFieldState();
}

class _CustomFormTextFieldState extends State<CustomFormTextField> {
  bool isPasswordShown = false;
  bool get isPasswordShownGetter => isPasswordShown;
  @override
  Widget build(BuildContext context) {
    return  Padding(
      padding: const EdgeInsets.all(12.0),
      child: TextFormField(
        controller: widget.controller,
        keyboardType: widget.keyboardType,
        validator: widget.validator,
        obscureText:widget.isObscureText ? !isPasswordShown : false,
        style: AppStyle.poppins400style14.copyWith(color: AppColors.whiteColor),
        cursorColor: AppColors.whiteColor,
        decoration: InputDecoration(
          prefixText: widget.startNumber??"",
          prefixStyle:AppStyle.poppins400style14.copyWith(color: AppColors.whiteColor) ,
          hintText: widget.hint ,
          hintStyle:  const TextStyle(color:AppColors.whiteColor ),
          enabledBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(8),
              borderSide: const BorderSide(
                color: AppColors.whiteColor
              )
          ),
          focusedBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(8),
              borderSide: const BorderSide(
                color: AppColors.whiteColor
              )
          ),
          suffixIcon: widget.isObscureText
              ? IconButton(
            icon: Icon(
              isPasswordShown
                  ? Icons.visibility
                  : Icons.visibility_off,
              color:AppColors.whiteColor,
            ),
            onPressed: () {
              setState(() {
                isPasswordShown = !isPasswordShown;
              });
            },
          )
              : null,
          prefixIcon: Icon(widget.prefix),
          prefixIconColor: AppColors.whiteColor

        ),
      ),
    );
  }
}