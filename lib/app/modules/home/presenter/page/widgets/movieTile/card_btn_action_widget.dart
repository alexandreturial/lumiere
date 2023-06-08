import 'package:flutter/material.dart';

class CardActionBtnWidget extends StatelessWidget {
  final Function actionBtn;
  final IconData iconCard;
  final Color colorCard;

  const CardActionBtnWidget(
      {super.key,
      required this.actionBtn,
      required this.iconCard,
      required this.colorCard});

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () => actionBtn(),
      child: Container(
        height: 60,
        width: 60,
        decoration: BoxDecoration(
          color: colorCard,
          borderRadius: BorderRadius.circular(12),
        ),
        child: Icon(iconCard),
      ),
    );
  }
}
