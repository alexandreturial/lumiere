import 'package:flutter/material.dart';

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
  _InputWidgetState createState() => _InputWidgetState();
}

class _InputWidgetState extends State<InputWidget> {
  @override
  Widget build(BuildContext context) {
    return Container(
      //margin: const EdgeInsets.only(bottom: 15),
      child: TextFormField(
        cursorColor: Theme.of(context).textSelectionTheme.cursorColor,
        initialValue: widget.initialValue,
        obscureText: widget.isObscureData,
        validator: (text) => widget.setValidate(text),
        onChanged: (text) => widget.setValue(text),
        keyboardType: widget.textType,
        focusNode: widget.myFocous,
        // style: AppTextStyles.textRegularH12.apply(
        //   color: Theme.of(context).colorScheme.surface
        // ),
        decoration: InputDecoration(
          suffixIcon: widget.suffixIcon,
          contentPadding: const EdgeInsets.symmetric(vertical: 0, horizontal: 10),
          hintText: widget.hintText,
          filled: true,
          // hintStyle: AppTextStyles.textRegularH12.apply(
          //   color: Theme.of(context).colorScheme.surface
          // ),
          prefixIcon: widget.prefixIcon,
          //prefixIconColor: AppColors.roude,
          // prefixIconColor: Theme.of(context).textSelectionTheme.cursorColor,
          fillColor: widget.fillColor ?? Theme.of(context).colorScheme.onBackground,
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(8),
            borderSide: BorderSide(color: Theme.of(context).colorScheme.onBackground, width: 1.0),
          ),
          enabledBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(8),
            borderSide: BorderSide(color: Theme.of(context).colorScheme.onBackground, width: 1.0),
          ),
          focusedBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(8),
            borderSide: BorderSide(color: Theme.of(context).colorScheme.onBackground, width: 1.0),
          ),
          errorText: widget.hasError ? "" : null,
          errorBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(8),
            // borderSide: BorderSide(color: AppColors.roude, width: 1.0),
          ),
        ),
      ),
    );
  }
}
