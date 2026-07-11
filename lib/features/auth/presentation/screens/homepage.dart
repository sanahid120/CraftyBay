import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../../../app/app_theme.dart';
import '../../../../app/extensions/localization_extension.dart';
import '../../../../app/providers/language_provider.dart';
import '../../../../app/providers/theme_provider.dart';
import '../../../../l10n/app_localizations.dart';

class Homepage extends StatelessWidget {
  const Homepage({super.key});
  static const String name = 'homepage';
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Column(
          crossAxisAlignment: .center,
          mainAxisSize: MainAxisSize.min,
          children: [
            SizedBox(height: 16),

            Text(AppLocalizations.of(context).hello),
            FilledButton(
              onPressed: () {
                Locale locale = context.read<LanguageProvider>().currentLocale;
                locale == Locale('en')
                    ? context.read<LanguageProvider>().changeLocale(
                        Locale('bn'),
                      )
                    : context.read<LanguageProvider>().changeLocale(
                        Locale('en'),
                      );
              },
              child: Text(context.localization.changeYourLanguage),
            ),
            SizedBox(height: 16),
            FilledButton(
              onPressed: () {
                context.read<ThemeProvider>().currentTheme ==
                        AppTheme.lightTheme
                    ? context.read<ThemeProvider>().changeTheme(
                        AppTheme.darkTheme,
                      )
                    : context.read<ThemeProvider>().changeTheme(
                        AppTheme.lightTheme,
                      );
              },
              child: Text(context.localization.changeTheme),
            ),
          ],
        ),
      ),
    );
  }
}
