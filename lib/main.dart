
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:todo_app/edittodo.dart';
import 'package:todo_app/homescreen.dart';
import 'package:todo_app/providers/user_provider.dart';
import 'package:todo_app/theming/mytheme.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:todo_app/providers/app_config_provider.dart';
import 'package:todo_app/register/login/loginscreen.dart';
import 'package:todo_app/register/registerscreen.dart';
import 'package:todo_app/settings.dart';
import 'package:todo_app/todoslist.dart';


import 'firebaseutils/firebase_options.dart';


void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform,);
  //await FirebaseFirestore.instance.disableNetwork();
  runApp(MultiProvider(providers: [
    ChangeNotifierProvider(create: (context){
      return AppConfigProvider();
    }),
    ChangeNotifierProvider(create: (context){
      return UserProvider();
    })
  ],child: MyApp(),));
  //await Firebase.initializeApp();
 // await FirebaseFirestore.instance.disableNetwork();
 // FirebaseFirestore.instance.settings=Settings(cacheSizeBytes: Settings.CACHE_SIZE_UNLIMITED);
 }

class MyApp extends StatefulWidget {

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  @override
  Widget build(BuildContext context) {
    var provider=Provider.of<AppConfigProvider>(context);
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: MyTheme.lightMode,
      darkTheme: MyTheme.darktMode,
      themeMode: provider.appMode,
      //initialRoute: HomeScreen.routeName,
      initialRoute: LoginScreen.routeName,
      //initialRoute: RegisterScreen.routeName,
      localizationsDelegates: AppLocalizations.localizationsDelegates,
      supportedLocales: AppLocalizations.supportedLocales,
      locale: Locale(provider.appLanguage),
      routes: {
        HomeScreen.routeName:(context)=>HomeScreen(),
        ToDosScreen.routeName:(context)=>ToDosScreen(),
        SettingsScreen.routeName:(context)=>SettingsScreen(),
        EditTodoScreen.routeName:(context)=>EditTodoScreen(),
        LoginScreen.routeName:(context)=>LoginScreen(),
        RegisterScreen.routeName:(context)=>RegisterScreen(),
      },

    );
  }




}


