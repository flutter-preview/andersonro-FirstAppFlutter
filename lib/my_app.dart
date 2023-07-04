import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';
import 'package:trilhaapp/pages/splash_page.dart';
import 'package:trilhaapp/service/contador_service.dart';
import 'package:trilhaapp/service/dark_mode_service.dart';
import 'package:trilhaapp/service/tarefa_provider_repository.dart';

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider<DarkModeService>(
            create: (_) => DarkModeService()),
        ChangeNotifierProvider<ContadorService>(create: (_)=>ContadorService()),
        ChangeNotifierProvider<TarefaProviderRepository>(create: (_)=>TarefaProviderRepository())
      ],
      child: Consumer<DarkModeService>(
        builder: (build, darkModeService, widget) {
          return MaterialApp(
            debugShowCheckedModeBanner: false,
            themeMode: darkModeService.darkMode ? ThemeMode.dark : ThemeMode.light,
            theme: ThemeData(
              //primarySwatch: Colors.orange,
              textTheme: GoogleFonts.robotoTextTheme(),
              primaryColor: Colors.white,
              brightness: Brightness.light,
              primaryColorDark: Colors.black,
              canvasColor: Colors.white,
              // next line is important!
              appBarTheme: AppBarTheme(brightness: Brightness.light)
            ),
            darkTheme: ThemeData(
                primaryColor: Colors.black,
                primaryColorLight: Colors.black,
                brightness: Brightness.dark,
                primaryColorDark: Colors.black,
                indicatorColor: Colors.white,
                canvasColor: Colors.black,
                // next line is important!
                appBarTheme: AppBarTheme(brightness: Brightness.dark)
            ),
            home: const SplashPage(),
          );
        }
      ),
    );
  }
}
