import 'package:flutter/material.dart';

class TextWidget extends StatefulWidget {
  final bool isLoading;
  final double size;
  final Text textComponentWidget;
  const TextWidget(
      {super.key, required this.isLoading, required this.textComponentWidget, required this.size});

  @override
  State<TextWidget> createState() => _TextWidgetState();
}

class _TextWidgetState extends State<TextWidget> {
  @override
  Widget build(BuildContext context) {
    return widget.isLoading
        ? Container(
            width: widget.size,
            height: 16,
            decoration: BoxDecoration(
                color: Colors.black, borderRadius: BorderRadius.circular(16)),
          )
        : widget.textComponentWidget;
  }
}
