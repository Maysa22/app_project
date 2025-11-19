part of 'login_cubit.dart';

@immutable
abstract class LoginState {}

final class LoginInitialState extends LoginState {}
final class LoginLoadingState extends LoginState {

}
final class LoginSuccessState extends LoginState {
  AdminResponse adminResponse;
  LoginSuccessState(this.adminResponse);
}
final class LoginErrorState extends LoginState {
  String error ;
  LoginErrorState(this.error);
}
class AdminLoginChangePasswordVisibilityState extends LoginState{}