import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:modal_progress_hud_nsn/modal_progress_hud_nsn.dart';
import 'package:mychat_app/constants.dart';
import 'package:mychat_app/helper/snack_bar.dart';
import 'package:mychat_app/pages/chat_page.dart';
import 'package:mychat_app/pages/cubit/login_cubit/login_cubit.dart';
import 'package:mychat_app/pages/register_page.dart';
import 'package:mychat_app/widget/custom_button.dart';
import 'package:mychat_app/widget/custom_textfild.dart';

class LoginPage extends StatelessWidget {
  String? email, password;
  static String id = 'loginpage';
  GlobalKey<FormState> formkey = GlobalKey();

  bool isloding = false;

  @override
  Widget build(BuildContext context) {
    return BlocListener<LoginCubit, LoginState>(
      listener: (context, state) {
       if(state is LoginLoading){
        isloding=true;
       }
       else if(state is LoginSuccess){
        Navigator.pushNamed(context, ChatPage.id);
        isloding=false;
       }
       else if(state is LoginFailur){
        showsnackbar(context, state.errMessage);
        isloding=false;
       }
      },
      child: ModalProgressHUD(
        inAsyncCall: isloding,
        child: Scaffold(
          backgroundColor: kPrimaryColor,
          body: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 8),
            child: Form(
              key: formkey,
              child: ListView(
                children: [
                  SizedBox(
                    height: 75,
                  ),
                  Image.asset(
                    'assets/images/scholar.png',
                    height: 100,
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      const Text(
                        'Scholaer Chat',
                        style: TextStyle(
                          color: Colors.white,
                          fontFamily: 'Pacifico',
                        ),
                      ),
                    ],
                  ),
                  SizedBox(
                    height: 75,
                  ),
                  Text(
                    'LOGIN',
                    style: TextStyle(
                      color: Colors.white,
                    ),
                  ),
                  SizedBox(
                    height: 20,
                  ),
                  CustomTextfild(
                    onChanged: (data) {
                      email = data;
                    },
                    hinttext: "Email",
                  ),
                  SizedBox(
                    height: 10,
                  ),
                  CustomTextfild(
                    obsecuertext: true,
                    onChanged: (data) {
                      password = data;
                    },
                    hinttext: "Password",
                  ),
                  SizedBox(
                    height: 15,
                  ),
                  CustomButton(
                    onTap: () async {
                      if (formkey.currentState!.validate()) {
                        BlocProvider.of<LoginCubit>(context).loginuser(email: email!, password: password!);
                      }
                    },
                    txt: 'Login',
                  ),
                  SizedBox(
                    height: 15,
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(
                        'dont\'t have an account?',
                        style: TextStyle(
                          color: Colors.white,
                        ),
                      ),
                      GestureDetector(
                        onTap: () {
                          Navigator.pushNamed(context, RegisterPage.id);
                        },
                        child: Text(
                          '  Register',
                          style: TextStyle(
                            color: Color(0xffC7EDE6),
                          ),
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

 
}
Future<void> loginuser({required String email,required String password}) async {
    
 
      
  UserCredential userCredential = await FirebaseAuth.instance
      .signInWithEmailAndPassword(email: email!, password: password!);
     

  }
