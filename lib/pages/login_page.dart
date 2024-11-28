import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:modal_progress_hud_nsn/modal_progress_hud_nsn.dart';
import 'package:mychat_app/constants.dart';
import 'package:mychat_app/helper/snack_bar.dart';
import 'package:mychat_app/pages/chat_page.dart';
import 'package:mychat_app/pages/register_page.dart';
import 'package:mychat_app/widget/custom_button.dart';
import 'package:mychat_app/widget/custom_textfild.dart';

class LoginPage extends StatefulWidget {
  LoginPage({super.key});
  static String id = 'loginpage';

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  String? email, password;

  GlobalKey<FormState> formkey = GlobalKey();

  bool isloding = false;

  @override
  Widget build(BuildContext context) {
    return ModalProgressHUD(
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
                      isloding = true;
                      setState(() {});

                      try {
                        await loginuser();
                        Navigator.pushNamed(context, ChatPage.id,arguments: email);
                      } on FirebaseAuthException catch (e) {
                        if (e.code == 'user-not-found') {
                          showsnackbar(context, 'user not found');
                        } else if (e.code == 'wrong-password') {
                          showsnackbar(context, 'wrong-password');
                        }
                      }
                      isloding = false;
                      setState(() {});
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
    );
  }

  Future<void> loginuser() async {
    UserCredential userCredential = await FirebaseAuth.instance
        .signInWithEmailAndPassword(email: email!, password: password!);
  }
}
