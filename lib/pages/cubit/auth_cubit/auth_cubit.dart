import 'package:bloc/bloc.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:meta/meta.dart';

part 'auth_state.dart';

class AuthCubit extends Cubit<AuthState> {
  AuthCubit() : super(AuthInitial());

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
        emit(LoginFailur(errMessage: 'wrong-password'));
      }
    } catch (e) {
      emit(LoginFailur(errMessage: 'something went wrong'));
    }
  }

  Future<void> registeruser(
      {required String email, required String password}) async {
    emit(RegisterLoading());
    try {
      UserCredential user = await FirebaseAuth.instance
          .createUserWithEmailAndPassword(email: email, password: password);
      emit(RegisterSuccess());
    } on FirebaseAuthException catch (e) {
      if (e.code == 'weak-password') {
        emit(RegisterFailur(errMessage: 'weak-password'));
      } else if (e.code == 'email-already-in-use') {
        emit(RegisterFailur(errMessage: 'email-already-in-use'));
      }
    } catch (e) {
      emit(RegisterFailur(errMessage: 'something went wrong'));
    }
  }
}
