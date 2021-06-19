part of 'auth_bloc.dart';

abstract class AuthEvent extends Equatable {
  const AuthEvent();
}

class CheckAuth extends AuthEvent {
  @override
  List<Object> get props => [];
}

class SignIn extends AuthEvent {
  String username;
  String password;

  SignIn(this.username, this.password);

  @override
  List<Object> get props => [username, password];
}

class SignOut extends AuthEvent {
  @override
  List<Object> get props => [];
}

class SignUp extends AuthEvent {
  String email;
  String password;
  String name;

  SignUp(this.email, this.password, this.name);

  @override
  List<Object> get props => [email, password, name];
}
