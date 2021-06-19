part of 'auth_bloc.dart';

abstract class AuthState extends Equatable {
  const AuthState();
}

class AuthInitial extends AuthState {
  @override
  List<Object> get props => [];
}

class AuthLoading extends AuthState {
  @override
  List<Object> get props => [];
}

class AuthSuccess extends AuthState {
  // final Application application;
  final uid;

  AuthSuccess(this.uid);

  @override
  List<Object> get props => [uid];
}

class AuthError extends AuthState {
  @override
  List<Object> get props => [];
}
