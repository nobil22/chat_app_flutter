part of 'auth_cubit.dart';

@immutable
abstract class AuthState {}

final class AuthInitial extends AuthState {}
 class LoginInitial extends AuthState {}
 class LoginLoading extends AuthState {}
 class LoginSuccess extends AuthState {}
 class LoginFailur extends AuthState {
   String errMessage;
  LoginFailur({required this.errMessage });
 }

 class RegisterInitial extends AuthState {}

class RegisterLoading extends AuthState {}

class RegisterSuccess extends AuthState {}

class RegisterFailur extends AuthState {
  String errMessage;
  RegisterFailur({required this.errMessage});
}