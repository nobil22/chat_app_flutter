import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:mychat_app/pages/chat_page.dart';
import 'package:mychat_app/pages/cubit/login_cubit/login_cubit.dart';
import 'package:mychat_app/pages/cubit/login_cubit/register_cubit/register_cubit.dart';
import 'package:mychat_app/pages/login_page.dart';
import 'package:mychat_app/pages/register_page.dart';
import 'package:firebase_core/firebase_core.dart';
import 'firebase_options.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  runApp(ScholarChat());
}

class ScholarChat extends StatelessWidget {
  ScholarChat({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
          BlocProvider<LoginCubit>(
      create: (BuildContext context) =>LoginCubit(),
    ),
    BlocProvider<RegisterCubit>(
      create: (BuildContext context) => RegisterCubit(),
    ),
      ],
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        routes: {
          LoginPage.id: (context) => LoginPage(),
          RegisterPage.id: (context) => RegisterPage(),
          ChatPage.id: (context) => ChatPage(),
        },
        home: LoginPage(),
      ),
    );
  }
}
