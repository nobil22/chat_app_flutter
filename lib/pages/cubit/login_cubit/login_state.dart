part of 'login_cubit.dart';

@immutable
abstract class LoginState {}

 class LoginInitial extends LoginState {}
 class LoginLoading extends LoginState {}
 class LoginSuccess extends LoginState {}
 class LoginFailur extends LoginState {
   String errMessage;
  LoginFailur({required this.errMessage });
 }
