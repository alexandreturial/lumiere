import 'package:flutter/material.dart';
import 'package:lumiere/app/shared/core/styles/app_colors.dart';
import 'package:lumiere/app/shared/core/styles/app_text_style.dart';

class InputWidget extends StatefulWidget {
  final bool isObscureData;
  final bool hasError;
  final bool isLogin;
  final String hintText;
  final TextInputType textType;
  final Function setValue;
  final Function setValidate;
  final Widget? suffixIcon;
  final Widget? prefixIcon;
  final String? initialValue;
  final int? maxSize;
  final Color? fillColor;
  final FocusNode? myFocous;

  const InputWidget({
    Key? key,
    required this.setValue,
    required this.setValidate,
    this.myFocous,
    this.isObscureData = false,
    this.hintText = "",
    this.hasError = false,
    this.textType = TextInputType.text,
    this.suffixIcon,
    this.prefixIcon,
    this.initialValue,
    this.maxSize = 60,
    this.isLogin = false,
    this.fillColor,
  }) : super(key: key);

  @override
  // ignore: library_private_types_in_public_api
  _InputWidgetState createState() => _InputWidgetState();
}

class _InputWidgetState extends State<InputWidget> {
  @override
  Widget build(BuildContext context) {
    return PhysicalModel(
      borderRadius: BorderRadius.circular(28),
      color: Theme.of(context).colorScheme.shadow,
      elevation: 4.0,
      shadowColor: Theme.of(context).colorScheme.shadow,
      child: TextFormField(
        cursorColor: Theme.of(context).textSelectionTheme.cursorColor,
        initialValue: widget.initialValue,
        obscureText: widget.isObscureData,
        validator: (text) => widget.setValidate(text),
        onChanged: (text) => widget.setValue(text),
        keyboardType: widget.textType,
        focusNode: widget.myFocous,
        style: AppTextStyles.textSemiBoldH14.apply(color: AppColors.textSecundary),
        decoration: InputDecoration(
          suffixIcon: widget.suffixIcon,
          contentPadding: const EdgeInsets.symmetric(vertical: 0, horizontal: 10),
          hintText: "vingadores...",
          prefixIcon: widget.prefixIcon,

        ),
      ),
    );
  }
}
