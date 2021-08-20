import 'dart:async';
import 'dart:convert';
import 'dart:io';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:guardiansapp/repositories/routine_repo.dart';
import 'package:meta/meta.dart';

import '../../helper_function.dart';

part 'routine_event.dart';
part 'routine_state.dart';

class RoutineBloc extends Bloc<RoutineEvent, RoutineState> {
  RoutineRepository routineRepository;
  RoutineBloc({required this.routineRepository}) : super(RoutineInitial());

  @override
  Stream<RoutineState> mapEventToState(
    RoutineEvent event,
  ) async* {
    if (event is RoutineButtonPressed) {
      yield RoutineLoading();
      try {
        var res = await getFromSharedPreferences('response');
        var token = json.decode(res)['token'];
        if (token != '_') {
          var response = await routineRepository.getRoutine(
              token: token, studentId: event.studentId);
          if (response['status'] == 0) {
            yield RoutineLoadingFailure(error: {
              "exception_type": "SocketException",
              "message": response['message']
            });
          } else {
            yield RoutineLoaded(content: response['routine']);
          }
        }
      } catch (error) {
        if (error is SocketException) {
          yield RoutineLoadingFailure(error: {
            "exception_type": "SocketException",
            "message": "No Internet Connection!"
          });
        } else {
          yield RoutineLoadingFailure(error: {
            "exception_type": "GeneralException",
            "message": "An error occured. Please try again! $error"
          });
        }
      }
    }
  }
}
