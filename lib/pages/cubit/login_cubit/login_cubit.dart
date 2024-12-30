import 'dart:math';

import 'package:bloc/bloc.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/foundation.dart';

part 'login_state.dart';

class LoginCubit extends Cubit<LoginState> {
  LoginCubit() : super(LoginInitial());

  Future<void> loginuser(
      {required String email, required String password}) async {
    emit(LoginLoading());
    try {
      UserCredential userCredential = await FirebaseAuth.instance
          .signInWithEmailAndPassword(email: email!, password: password!);
      emit(LoginSuccess());
    } on FirebaseAuthException catch (e) {
      if (e.code == 'user-not-found') {
        emit(LoginFailur(errMessage: 'user-not-found'));
      } else if (e.code == 'wrong-password') {
        emit(LoginFailur(errMessage:'wrong-password'  ));
      }
    } catch (e) {
      emit(LoginFailur( errMessage:'something went wrong'));
    }
  }
}
