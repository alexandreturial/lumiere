import 'package:flutter/material.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:lumiere/app/shared/models/enviromant.dart';

import 'app/app_module.dart';
import 'app/app_widget.dart';

import 'package:intl/date_symbol_data_local.dart';

void main() async{

  await dotenv.load(
    fileName: Enviroment.filename
  );
  
  WidgetsFlutterBinding.ensureInitialized();

  initializeDateFormatting().then((_) => runApp(ModularApp(module: AppModule(), child: AppWidget())));
}
