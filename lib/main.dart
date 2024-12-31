import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:mychat_app/pages/bloc/auth_bloc/auth_bloc.dart';
import 'package:mychat_app/pages/chat_page.dart';
import 'package:mychat_app/pages/cubit/auth_cubit/auth_cubit.dart';
import 'package:mychat_app/pages/cubit/chat_cubit/chat_cubit.dart';
import 'package:mychat_app/pages/login_page.dart';
import 'package:mychat_app/pages/register_page.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:mychat_app/simble_bloc_observer.dart';
import 'firebase_options.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  BlocOverrides.runZoned((){
     runApp(ScholarChat());
  },
  blocObserver: SimbleBlocObserver(),
  );
 
}

class ScholarChat extends StatelessWidget {
  ScholarChat({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
    BlocProvider(create: (context)=>AuthBloc()),
   BlocProvider(create: (context)=>AuthCubit()),
    BlocProvider(create: (context)=>ChatCubit()),
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
