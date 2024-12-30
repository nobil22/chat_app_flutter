import 'package:bloc/bloc.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:meta/meta.dart';

part 'register_state.dart';

class RegisterCubit extends Cubit<RegisterState> {
  RegisterCubit() : super(RegisterInitial());
   Future<void> registeruser({required String email,required String password}) async {
    emit(RegisterLoading());
    try {
  UserCredential userCredential = await FirebaseAuth.instance
      .createUserWithEmailAndPassword(email: email!, password: password!);
      emit(RegisterSuccess());
      } on FirebaseAuthException catch (e) {
                        if (e.code == 'weak-password') {
                         emit(RegisterFailur(errMessage: 'weak-password'));
                        } else if (e.code == 'email-already-in-use') {
                          emit(RegisterFailur(errMessage: 'email-already-in-use'));
                        }
                      
}  catch (e) {
  emit(RegisterFailur(errMessage: 'something went wrong'));
}
  }
}
