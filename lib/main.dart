import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:my_profile/controller/app_state_controller.dart';
import 'package:my_profile/model/app_state.dart';
import 'package:my_profile/screens/login/login_screen.dart';

final appStateNotifier =    StateNotifierProvider<AppStateController,AppState>((ref){
  return AppStateController( AppState());
});
void main() {
  runApp(const ProviderScope(child: MyApp()));
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {

    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Flutter Demo',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        useMaterial3: true,
      ),
      home:  LoginScreen(),
    );
  }
}