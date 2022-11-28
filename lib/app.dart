import 'package:flutter/material.dart';
import 'package:frontend_api_congressman/congressmans/views/views.dart';

class App extends StatelessWidget {
  const App({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        colorScheme: ThemeData()
            .colorScheme
            .copyWith(primary: const Color.fromARGB(255, 3, 170, 128)),
        appBarTheme: const AppBarTheme(
          backgroundColor: Color.fromARGB(255, 3, 170, 128),
        ),
        scaffoldBackgroundColor: Colors.grey[200],
      ),
      home: SearchPageView(),
    );
  }
}
