part of 'absent_bloc.dart';

abstract class AbsentState extends Equatable {
  const AbsentState();
}

class AbsentInitial extends AbsentState {
  @override
  List<Object> get props => [];
}

class AbsentLoading extends AbsentState {
  @override
  List<Object> get props => [];
}

class AbsentSuccess extends AbsentState {
  // final Application application;
  dynamic data;

  AbsentSuccess(this.data);

  @override
  List<Object> get props => [data];
}

class AbsentInSuccess extends AbsentState {
  // final Application application;
  final data;

  AbsentInSuccess(this.data);

  @override
  List<Object> get props => [data];
}

class AbsentOutSuccess extends AbsentState {
  // final Application application;
  final data;

  AbsentOutSuccess(this.data);

  @override
  List<Object> get props => [data];
}

class CheckUserActiveSuccess extends AbsentState {
  // final Application application;
  final data;

  CheckUserActiveSuccess(this.data);

  @override
  List<Object> get props => [data];
}

class GetAllUserSuccess extends AbsentState {
  final data;

  GetAllUserSuccess(this.data);

  @override
  List<Object> get props => [data];
}

class AbsentError extends AbsentState {
  @override
  List<Object> get props => [];
}
