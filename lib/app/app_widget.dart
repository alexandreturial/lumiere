import 'package:flutter/material.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:lumiere/app/shared/core/styles/color_schemes.g.dart';
import 'package:lumiere/app/shared/app_controller_store.dart';

class AppWidget extends StatefulWidget {
  const AppWidget({Key? key}) : super(key: key);

  @override
  State<AppWidget> createState() => _AppWidgetState();
}

class _AppWidgetState extends State<AppWidget> {
  final AppControllerStore appControllerStore = Modular.get();

  @override
  void initState() {
    super.initState();
    startTheme();
  }

  startTheme() async {
    await appControllerStore.getTheme();
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp.router(
        routeInformationParser: Modular.routeInformationParser,
        routerDelegate: Modular.routerDelegate,
        title: 'Lumiere',
        theme: appControllerStore.value.theme);
  }
}
