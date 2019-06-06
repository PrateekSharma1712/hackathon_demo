import 'package:flutter/material.dart';
import 'package:hackathon_demo/dialogflow/dialog_flow_service.dart';
import 'package:hackathon_demo/pages/chat_screen.dart';
import 'package:hackathon_demo/splash/splash.dart';
import 'package:hackathon_demo/user/user_login.dart';
import 'package:provider/provider.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(primaryColor: Color(0xffC523FF), canvasColor: Colors.white),
      home: AppSplashScreen(),
      routes: {
        "/login": (context) => UserLogin(),
        "/chat": (context) => Provider<DialogFlowService>(
              child: ChatScreen(),
              builder: (context) => DialogFlowService(),
            ),
      },
    );
  }
}
