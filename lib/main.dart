import 'package:flutter/material.dart';
import 'package:parse_server_sdk_flutter/parse_server_sdk_flutter.dart';
import 'package:provider/provider.dart';
import 'package:shelfsync/inventory/controller/inventory_controller.dart';
import 'package:shelfsync/tab/tab_page.dart';
import 'package:shelfsync/pos/controller/order_controller.dart';
import 'package:shelfsync/pos/controller/pos_controller.dart';
import 'auth/ui/login_page.dart';

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

  runApp(
    MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (_) => InventoryController()),
        ChangeNotifierProvider(create: (_) => PosController()),
        ChangeNotifierProvider(create: (_) => OrderController()),
      ],
      child: MyApp(isLoggedIn: sessionIsValid),
    ),
  );
}

class MyApp extends StatelessWidget {
  final bool isLoggedIn;
  const MyApp({super.key, required this.isLoggedIn});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'ShelfSync',
      theme: ThemeData(
        useMaterial3: true,
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.blueAccent),
      ),
      home: isLoggedIn ? const TabPage() : const LoginPage(),
    );
  }
}
