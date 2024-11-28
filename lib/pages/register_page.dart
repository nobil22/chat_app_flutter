import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:modal_progress_hud_nsn/modal_progress_hud_nsn.dart';
import 'package:mychat_app/constants.dart';
import 'package:mychat_app/helper/snack_bar.dart';
import 'package:mychat_app/pages/chat_page.dart';
import 'package:mychat_app/pages/login_page.dart';
import 'package:mychat_app/widget/custom_button.dart';
import 'package:mychat_app/widget/custom_textfild.dart';

class RegisterPage extends StatefulWidget {
  RegisterPage({super.key});
  static String id = 'registerpage';

  @override
  State<RegisterPage> createState() => _RegisterPageState();
}

class _RegisterPageState extends State<RegisterPage> {
  String? email;

  String? password;

  bool isloding = false;

  GlobalKey<FormState> formkey = GlobalKey();

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
                const SizedBox(
                  height: 75,
                ),
                Image.asset(
                  'assets/images/scholar.png',
                  height: 100,
                ),
                const Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      'Scholaer Chat',
                      style: TextStyle(
                        color: Colors.white,
                        fontFamily: 'Pacifico',
                      ),
                    ),
                  ],
                ),
                const SizedBox(
                  height: 75,
                ),
                const Text(
                  'REGISTER',
                  style: TextStyle(
                    color: Colors.white,
                  ),
                ),
                const SizedBox(
                  height: 20,
                ),
                CustomTextfild(
                  onChanged: (data) {
                    email = data;
                  },
                  hinttext: "Email",
                ),
                const SizedBox(
                  height: 10,
                ),
                CustomTextfild(
                  onChanged: (data) {
                    password = data;
                  },
                  hinttext: "Password",
                ),
                const SizedBox(
                  height: 15,
                ),
                CustomButton(
                  onTap: () async {
                    if (formkey.currentState!.validate()) {
                      isloding = true;
                      setState(() {});

                      try {
                        await registeruser();
                        Navigator.pushNamed(context, ChatPage.id);
                      } on FirebaseAuthException catch (e) {
                        if (e.code == 'weak-password') {
                          showsnackbar(context, 'weak-password');
                        } else if (e.code == 'email-already-in-use') {
                          showsnackbar(context, 'email-already-in-use');
                        }
                      }
                      isloding = false;
                      setState(() {});
                    }
                  },
                  txt: 'Register',
                ),
                const SizedBox(
                  height: 15,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    const Text(
                      'dont\'t have an account?',
                      style: TextStyle(
                        color: Colors.white,
                      ),
                    ),
                    GestureDetector(
                      onTap: () {
                        Navigator.pop(context);
                      },
                      child: const Text(
                        '  Login',
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

  

  Future<void> registeruser() async {
    UserCredential userCredential = await FirebaseAuth.instance
        .createUserWithEmailAndPassword(email: email!, password: password!);
  }
}
