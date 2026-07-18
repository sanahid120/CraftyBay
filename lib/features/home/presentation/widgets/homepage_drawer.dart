import 'package:craftybay/features/auth/presentation/screens/sign_in_screen.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../../../app/app_theme.dart';
import '../../../../app/controllers/auth_controller.dart';
import '../../../../app/extensions/localization_extension.dart';
import '../../../../app/network_caller_set_up.dart';
import '../../../../app/providers/language_provider.dart';
import '../../../../app/providers/theme_provider.dart';
import '../../../auth/presentation/widgets/app_logo.dart';

class HomepageDrawer extends StatelessWidget {
  const HomepageDrawer({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: Consumer2<ThemeProvider, LanguageProvider>(
        builder: (context, themeProvider, languageProvider, _) {
          final bool isLoggedIn = AuthController.token != null;
          return ListView(
            padding: EdgeInsets.zero,
            children: [
              DrawerHeader(
                decoration: BoxDecoration(color: Colors.grey.withAlpha(50)),
                child: AppLogo(),
              ),
              ListTile(
                leading: themeProvider.currentTheme == AppTheme.lightTheme
                    ? const Icon(Icons.light_mode)
                    : Icon(Icons.dark_mode),
                title: Text(context.localization.changeTheme),
                trailing: Switch.adaptive(
                  value: themeProvider.currentTheme == AppTheme.lightTheme,
                  onChanged: (value) {
                    context.read<ThemeProvider>().currentTheme ==
                        AppTheme.lightTheme
                        ? context.read<ThemeProvider>().changeTheme(
                      AppTheme.darkTheme,
                    )
                        : context.read<ThemeProvider>().changeTheme(
                      AppTheme.lightTheme,
                    );
                  },
                  padding: EdgeInsets.zero,
                ),
              ),

              ListTile(
                leading: Icon(Icons.language),
                title: Text(context.localization.changeYourLanguage),
                trailing: DropdownButton<Locale>(
                  value: languageProvider.currentLocale,
                  onChanged: (locale) {
                    languageProvider.changeLocale(locale!);
                  },
                  items: [
                    DropdownMenuItem(
                      value: Locale('en'),
                      child: Text('English'),
                    ),
                    DropdownMenuItem(
                      value: Locale('bn'),
                      child: Text('বাংলা'),
                    ),

                  ],
                ),
              ),

                ListTile(


                  leading: Icon(isLoggedIn ? Icons.logout : Icons.login),
                  title: Text(isLoggedIn ? context.localization.logout : context.localization.login),
                  onTap: () {
                    isLoggedIn ? logout() : Navigator.pushNamed(context, SignInScreen.name);

                    AuthController.removeUserData();

                  },
                ),

            ],
          );
        },
      ),
    );
  }
}
