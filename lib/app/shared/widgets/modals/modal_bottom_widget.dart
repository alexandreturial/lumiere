import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:lumiere/app/shared/core/styles/core.dart';
import 'package:lumiere/app/utils/responsive.dart';

class ModalBottomWidget extends StatelessWidget {
  final bool isSucceeded;
  final Function succeededAction;
  final Function errorAction;
  final Function retryAction;
  const ModalBottomWidget({Key? key, required this.isSucceeded, required this.succeededAction, required this.errorAction, required this.retryAction})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    final Responsive responsive = Responsive(context);
    return SizedBox(
      height: 300,
      child: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          mainAxisSize: MainAxisSize.min,
          children: <Widget>[
            SvgPicture.asset(
              isSucceeded ? AppImages.succeededAction : AppImages.errorAction,
              width: 150,
              height: 150,
            ),
            const SizedBox(
              height: 14,
            ),
            SizedBox(
              width: responsive.wp(60),
              child: Text(
                isSucceeded
                    ? "Filme salvo com sucesso!"
                    : "Infelizmente não conseguimos salvar seu filme",
                style: AppTextStyles.textBoldH14,
                textAlign: TextAlign.center,
                maxLines: 2,
              ),
            ),
            const SizedBox(
              height: 24,
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  isSucceeded
                      ? ElevatedButton(
                          child: const Text('procurar outro filme'),
                          onPressed: () => errorAction(),
                        )
                      : ElevatedButton(
                          child: const Text('Tentar novamente'),
                          onPressed: () => retryAction(),
                        ),
                  OutlinedButton(
                    child: const Text('Retornar a home'),
                    onPressed: () => succeededAction(),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
