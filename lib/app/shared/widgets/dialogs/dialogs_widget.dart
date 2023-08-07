import 'package:flutter/material.dart';
import 'package:lumiere/app/shared/core/styles/app_text_style.dart';
import 'package:lumiere/app/shared/widgets/dialogs/dialogs_types.dart';

class Dialogs {
  // final DialogsTypes type;
  // final String message;
  // final int code;

  const Dialogs();

  static handleDilalog(BuildContext context,
      {type, title, message, List<Widget>? actions}) {
    switch (type) {
      case DialogsTypes.ErrorDialog:
        _getDialog(
          context,
          title: title,
          message: message,
          actionsButtons: actions,
          color: Theme.of(context).colorScheme.onError,
          icon: const Icon(Icons.error),
        );
        return;
      case DialogsTypes.WarningDialog:
        _getDialog(
          context,
          title: title,
          message: message,
          actionsButtons: actions,
          color: Colors.orange[600],
          icon: const Icon(Icons.warning),
        );
        return;
      case DialogsTypes.SucessDialog:
        _getDialog(
          context,
          title: title,
          message: message,
          actionsButtons: actions,
          color: Colors.green[800],
          icon: const Icon(Icons.check),
        );
        return;
      default:
    }
  }

  static _getDialog(BuildContext context,
      {title,
      message,
      Color? color,
      Icon? icon,
      List<Widget>? actionsButtons}) {
    return showDialog<String>(
      context: context,
      builder: (BuildContext context) => AlertDialog(
        titlePadding: const EdgeInsets.symmetric(vertical: 12, horizontal: 8),
        alignment: Alignment.bottomCenter,
        backgroundColor: color,
        title: Row(
          children: [
            Container(
              padding: const EdgeInsets.all(8.0),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(25),
                color: Theme.of(context).colorScheme.error.withOpacity(0.3),
              ),
              child: icon,
            ),
            const SizedBox(
              width: 8,
            ),
            Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                SizedBox(
                  width: 200,
                  child: Text(
                    title,
                    style: AppTextStyles.textMediumH14,
                    maxLines: 2,
                    overflow: TextOverflow.ellipsis,
                  ),
                ),
                Text(message, style: AppTextStyles.textRegularH12),
              ],
            )
          ],
        ),
        actionsAlignment: MainAxisAlignment.spaceEvenly,
        actionsPadding: const EdgeInsets.symmetric(horizontal: 8),
        actions: actionsButtons,
      ),
    );
  }

  Widget primaryButton(
      DialogsTypes type, 
      BuildContext context, {
        required String title, 
        required Function action
      }) {
    return ElevatedButton(
      onPressed: () => action(),
      style: ButtonStyle(
        backgroundColor: MaterialStateProperty.resolveWith((states) {
          return getBackgorundColorBytype(type, context);
        }),
      ),
      child: Text(
        title,
        style: AppTextStyles.textMediumH14.apply(
          color: getTextColorBytype(type),
        ),
      ),
    );
  }

  Widget secundaryButtton(
      DialogsTypes type, BuildContext context, {
        required String title, 
        required Function action
      }) {
    return TextButton(
      onPressed: () => action(),
      child: Text(
        title,
        style: AppTextStyles.textMediumH14.apply(
          color: getTextColorBytype(type),
        ),
      ),
    );
  }

  static Color? getBackgorundColorBytype(
      DialogsTypes type, BuildContext context) {
    switch (type) {
      case DialogsTypes.ErrorDialog:
        return Theme.of(context).colorScheme.onError;
      case DialogsTypes.WarningDialog:
        return Colors.orange[600];
      case DialogsTypes.SucessDialog:
        return Colors.green[800];
      default:
        return Colors.green[800];
    }
  }

  static Color? getTextColorBytype(DialogsTypes type) {
    switch (type) {
      case DialogsTypes.ErrorDialog:
        return Colors.white;
      case DialogsTypes.WarningDialog:
        return Colors.white;
      case DialogsTypes.SucessDialog:
        return Colors.white;
      default:
        return Colors.white;
    }
  }
}
