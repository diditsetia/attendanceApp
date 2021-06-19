import 'dart:async';

import 'package:attendance/infrastructure/repositories/absent_repository.dart';
import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:get_it/get_it.dart';

part 'absent_event.dart';
part 'absent_state.dart';

class AbsentBloc extends Bloc<AbsentEvent, AbsentState> {
  AbsentBloc() : super(AbsentInitial());

  AbsentRepository get _repository => GetIt.I<AbsentRepository>();

  @override
  Stream<AbsentState> mapEventToState(
    AbsentEvent event,
  ) async* {
    if (event is AbsentIn) {
      try {
        yield AbsentLoading();
        final result = await _repository.absentIn(
          event.username,
          event.date,
          event.absenIn,
          event.absenOut,
          event.workingHrs,
          event.uId,
          event.idAbsenString,
          event.statusAbsent,
        );

        yield (AbsentInSuccess(result));
        // yield (AbsentSuccess());
      } catch (e) {
        var ab = e;
        print(ab);
        yield AbsentError();
      }
    }

    if (event is GetDataAbsent) {
      try {
        yield AbsentLoading();
        final result = await _repository.getAbsent(event.uId);
        yield (AbsentSuccess(result));
      } catch (e) {
        yield AbsentError();
      }
    }

    if (event is AbsentOut) {
      try {
        yield AbsentLoading();
        final result = await _repository.absentOut(
          event.absenout,
          event.workingHrs,
          event.idUser,
          event.status,
          event.uId,
        );

        yield (AbsentOutSuccess(result));
      } catch (e) {
        yield AbsentError();
      }
    }
    if (event is CheckUserActive) {
      try {
        yield AbsentLoading();
        final result = await _repository.checkUserActive(
          event.uId,
        );

        yield (CheckUserActiveSuccess(result));
      } catch (e) {
        yield AbsentError();
      }
    }

    if (event is GetAllUserAbsent) {
      try {
        yield AbsentLoading();
        final result = await _repository.getAllUserAbsent();
        yield GetAllUserSuccess(result);
      } catch (e) {}
    }
  }
}
