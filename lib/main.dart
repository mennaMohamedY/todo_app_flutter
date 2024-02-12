
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:todo_app/edittodo.dart';
import 'package:todo_app/homescreen.dart';
import 'package:todo_app/mytheme.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:todo_app/providers/app_config_provider.dart';
import 'package:todo_app/settings.dart';
import 'package:todo_app/todoslist.dart';

void main() {
  runApp(ChangeNotifierProvider(
      create: (context){
        return AppConfigProvider();
      }
      ,child: MyApp()));
}

class MyApp extends StatelessWidget {

  @override
  Widget build(BuildContext context) {
    var provider=Provider.of<AppConfigProvider>(context);
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: MyTheme.lightMode,
      darkTheme: MyTheme.darktMode,
      themeMode: provider.appMode,
      initialRoute: HomeScreen.routeName,
      localizationsDelegates: AppLocalizations.localizationsDelegates,
      supportedLocales: AppLocalizations.supportedLocales,
      locale: Locale(provider.appLanguage),
      routes: {
        HomeScreen.routeName:(context)=>HomeScreen(),
        ToDosScreen.routeName:(context)=>ToDosScreen(),
        SettingsScreen.routeName:(context)=>SettingsScreen(),
        EditTodoScreen.routeName:(context)=>EditTodoScreen()
      },

    );
  }
}


