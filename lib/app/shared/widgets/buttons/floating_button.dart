import 'package:flutter/material.dart';

class FloatingButtonWidget extends StatefulWidget {
  final IconData icon;
  final Function action;
  const FloatingButtonWidget(
      {super.key, required this.icon, required this.action});

  @override
  State<FloatingButtonWidget> createState() => _FloatingButtonWidgetState();
}

class _FloatingButtonWidgetState extends State<FloatingButtonWidget> {
  @override
  Widget build(BuildContext context) {
    return IconButton(
      onPressed: () => widget.action(),
      color: Colors.white,
      iconSize: 24,
      icon: Container(
        padding: const EdgeInsets.all(12),
        decoration: BoxDecoration(
          color: Theme.of(context).colorScheme.inversePrimary,
          borderRadius: BorderRadius.circular(25),
          border: Border.all(
              color: Theme.of(context).scaffoldBackgroundColor,
              width: 8,
              strokeAlign: 1),
        ),
        child: Icon(widget.icon),
      ),
    );
  }
}
