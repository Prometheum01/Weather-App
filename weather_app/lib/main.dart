import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:provider/provider.dart';
import 'package:weather_app/constants/colors.dart';

import 'package:weather_app/navigator/nav_routes.dart';
import 'package:weather_app/provider/main_provider.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (context) => MainProvider(),
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        theme: ThemeData(
            textTheme: TextTheme(
              headlineLarge: TextStyle(
                  color: ColorData.textColor,
                  fontWeight: FontWeight.w700,
                  fontFamily: "Montserrat",
                  fontStyle: FontStyle.normal,
                  fontSize: 59.0),
              headline1: TextStyle(
                  color: ColorData.textColor,
                  fontWeight: FontWeight.w700,
                  fontFamily: "Montserrat",
                  fontStyle: FontStyle.normal,
                  fontSize: 47.0),
              headline2: TextStyle(
                  color: ColorData.textColor,
                  fontWeight: FontWeight.w500,
                  fontFamily: "Montserrat",
                  fontStyle: FontStyle.normal,
                  fontSize: 36.0),
              headline3: TextStyle(
                  color: ColorData.textColor,
                  fontWeight: FontWeight.w400,
                  fontFamily: "Montserrat",
                  fontStyle: FontStyle.normal,
                  fontSize: 20.0),
              headline4: TextStyle(
                  color: ColorData.textColor,
                  fontWeight: FontWeight.w700,
                  fontFamily: "Montserrat",
                  fontStyle: FontStyle.normal,
                  fontSize: 15.0),
              headline5: TextStyle(
                  color: ColorData.textColor,
                  fontWeight: FontWeight.w500,
                  fontFamily: "Montserrat",
                  fontStyle: FontStyle.normal,
                  fontSize: 15.0),
              headline6: TextStyle(
                  color: ColorData.textColor,
                  fontWeight: FontWeight.w400,
                  fontFamily: "Montserrat",
                  fontStyle: FontStyle.normal,
                  fontSize: 11.0),
            ),
            appBarTheme: const AppBarTheme(
              elevation: 0,
              backgroundColor: Colors.transparent,
              systemOverlayStyle: SystemUiOverlayStyle.light,
            )),
        routes: NavigatorRoutes().items,
        initialRoute: Routes.loading.toPath(),
      ),
    );
  }
}
