import 'package:craftybay/shared/presentation/provider/homepage_main_nav_provider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:provider/provider.dart';

import '../features/auth/presentation/screens/splashScreen.dart';
import '../l10n/app_localizations.dart';
import 'app_routes.dart';
import 'providers/language_provider.dart';
import 'providers/theme_provider.dart';

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {

    return MultiProvider(
      providers: [

        ChangeNotifierProvider(create: (context)=> LanguageProvider()),
        ChangeNotifierProvider(create: (context)=> ThemeProvider()),
        ChangeNotifierProvider(create: (context)=> HomepageMainNavProvider()),
      ],
      child: Consumer2<LanguageProvider,ThemeProvider>(
          builder: ( context, languageProvider, themeProvider , child) {
            return MaterialApp(
              debugShowCheckedModeBanner: false,

              title: 'CraftyBay',
              localizationsDelegates: [
                AppLocalizations.delegate,
                GlobalMaterialLocalizations.delegate,
                GlobalWidgetsLocalizations.delegate,
                GlobalCupertinoLocalizations.delegate,
              ],

              locale: languageProvider.currentLocale,
              supportedLocales: languageProvider.supportedLocales,

              theme: themeProvider.currentTheme,



              initialRoute: '/',
              onGenerateRoute: AppRoutes.onGenerateRoute,

              home: SplashScreen(),
            );

          }
      ),
    );
  }
}