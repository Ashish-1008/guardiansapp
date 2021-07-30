import 'dart:async';
import 'dart:convert';
import 'dart:io';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:guardiansapp/repositories/exam_repository.dart';

import '../../helper_function.dart';

part 'exam_event.dart';
part 'exam_state.dart';

class ExamBloc extends Bloc<ExamEvent, ExamState> {
  ExamRepository examRepository = new ExamRepository();
  ExamBloc({required this.examRepository}) : super(ExamInitial());

  @override
  Stream<ExamState> mapEventToState(
    ExamEvent event,
  ) async* {
    if (event is SearchExamButtonPressed) {
      yield ExamLoading();
      try {
        var res = await getFromSharedPreferences('response');
        var token = json.decode(res)['token'];
        if (token != '_') {
          var response = await examRepository.getExamForSession(
              token: token, sessionId: event.sessionId);

          yield ExamLoaded(content: response);
        }
      } catch (error) {
        print(error);
        if (error is SocketException) {
          yield ExamLoadingFailure(error: {
            "exception_type": "SocketException",
            "message": "No Internet Connection!"
          });
        } else {
          yield ExamLoadingFailure(error: {
            "exception_type": "GeneralException",
            "message": "An error occured. Please try again! $error"
          });
        }
      }
    }
  }
}
