import 'package:flutter/material.dart';
import 'package:parse_server_sdk_flutter/parse_server_sdk_flutter.dart';
import 'package:shelfsync/main/main_page.dart';
import 'package:shelfsync/theme/shelf_sync_theme.dart';
import 'auth/login_page.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  const keyApplicationId = 'JcHrABhMGliwxoKzBPdGCRWmI7ifC7CXorQeXkG9';
  const keyClientKey = 'mPbVyWZ8jRfpTeTUs9Qh9IR7jrKugb1rBI6tnWYx';
  const keyParseServerUrl = 'https://parseapi.back4app.com';

  await Parse().initialize(
    keyApplicationId,
    keyParseServerUrl,
    clientKey: keyClientKey,
    autoSendSessionId: true,
    debug: true,
  );

  final currentUser = await ParseUser.currentUser() as ParseUser?;
  final sessionIsValid =
      currentUser != null &&
      (await ParseUser.getCurrentUserFromServer(
        currentUser.sessionToken!,
      ))!.success;

  runApp(MyApp(isLoggedIn: sessionIsValid));
}

class MyApp extends StatelessWidget {
  final bool isLoggedIn;
  const MyApp({super.key, required this.isLoggedIn});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'ShelfSync',
      theme: lightTheme,
      darkTheme: darkTheme,
      themeMode: ThemeMode.system,
      home: isLoggedIn ? const MainPage() : const LoginPage(),
    );
  }
}
