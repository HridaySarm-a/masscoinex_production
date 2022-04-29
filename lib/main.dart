import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:hive/hive.dart';
import 'package:masscoinex/routes/pages.dart';
import 'package:masscoinex/routes/route_list.dart';
import 'package:get/get.dart';
import 'package:responsive_sizer/responsive_sizer.dart';
import 'package:path_provider/path_provider.dart' as path_provider;

import 'global/global_vals.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  final appDocumentDir = await path_provider.getApplicationDocumentsDirectory();
  Hive.init(appDocumentDir.path);
  await Hive.openBox(GlobalVals.hiveBox);
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return ResponsiveSizer(
      builder: (context, orientation, screenType) {
        return GetMaterialApp(
          title: 'Masscoinex',
          theme: ThemeData(
            primarySwatch: Colors.blue,
            fontFamily: "Sans Fransisco Pro",
            appBarTheme: AppBarTheme(
              systemOverlayStyle: SystemUiOverlayStyle.light,
            ),
          ),
          debugShowCheckedModeBanner: false,
          initialRoute: Routes.splashScreen,
          getPages: Pages.pages,
        );
      },
    );
  }
}
