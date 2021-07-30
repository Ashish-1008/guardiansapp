import 'dart:async';
import 'dart:convert';
import 'dart:io';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:guardiansapp/repositories/marks_repository.dart';

import '../../helper_function.dart';

part 'marks_event.dart';
part 'marks_state.dart';

class MarksBloc extends Bloc<MarksEvent, MarksState> {
  MarksRepository marksRepository = new MarksRepository();
  MarksBloc({required this.marksRepository}) : super(MarksInitial());

  @override
  Stream<MarksState> mapEventToState(
    MarksEvent event,
  ) async* {
    if (event is MarksButtonPressed) {
      yield SessionLoading();
      try {
        var res = await getFromSharedPreferences('response');
        var token = json.decode(res)['token'];
        if (token != '_') {
          var response = await marksRepository.getSessions(
              token: token, studentId: event.studentId);

          yield SessionLoaded(content: response);
        }
      } catch (error) {
        print(error);
        if (error is SocketException) {
          yield SessionLoadingFailure(error: {
            "exception_type": "SocketException",
            "message": "No Internet Connection!"
          });
        } else {
          yield SessionLoadingFailure(error: {
            "exception_type": "GeneralException",
            "message": "An error occured. Please try again! $error"
          });
        }
      }
    }

    if (event is FinalResultButtonPressed) {
      yield ResultLoading();
      try {
        var res = await getFromSharedPreferences('response');
        var token = json.decode(res)['token'];
        if (token != '_') {
          var response = await marksRepository.getMarksForSession(
              token: token,
              sessionId: event.sessionId,
              examId: event.examId,
              studentId: event.studentId);

          yield ResultLoaded(content: response);
        }
      } catch (error) {
        print(error);
        if (error is SocketException) {
          yield ResultLoadingFailure(error: {
            "exception_type": "SocketException",
            "message": "No Internet Connection!"
          });
        } else {
          yield ResultLoadingFailure(error: {
            "exception_type": "GeneralException",
            "message": "An error occured. Please try again! $error"
          });
        }
      }
    }
  }
}
