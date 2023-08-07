
import 'package:flutter/material.dart';
import 'package:lumiere/app/shared/core/styles/core.dart';

class ActiveBtnWidget extends StatelessWidget {
  final String title;
  final Function action;
  final bool isActive;
  const ActiveBtnWidget({super.key, required this.title, required this.action, required this.isActive});

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () => action(),
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
        decoration: BoxDecoration(
          color: isActive ? Theme.of(context).colorScheme.primaryContainer : Colors.transparent,
          border: Border.all(
              width: 2,
              strokeAlign: BorderSide.strokeAlignInside,
              color: Theme.of(context).colorScheme.primaryContainer,
            ),
          borderRadius: BorderRadius.circular(12)
        ),
        child: Text(title, style: AppTextStyles.textMediumH14, textAlign: TextAlign.center,),
      ),
    );
  }
}