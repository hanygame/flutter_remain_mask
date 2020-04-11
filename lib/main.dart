import 'package:flutter/material.dart';
import 'package:fluttermaskapp/ui/view/main_page.dart';
import 'package:fluttermaskapp/viewmodel/store_viewmodel.dart';
import 'package:provider/provider.dart';

import 'model/store.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  runApp(ChangeNotifierProvider.value(
    value: StoreViewModel(),
    child: MyApp(),
  ));
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: MainPage(),
    );
  }
}
