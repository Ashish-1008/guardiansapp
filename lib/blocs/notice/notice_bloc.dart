import 'dart:async';
import 'dart:convert';
import 'dart:io';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:guardiansapp/repositories/notice_repository.dart';
import 'package:meta/meta.dart';

import '../../helper_function.dart';

part 'notice_event.dart';
part 'notice_state.dart';

class NoticeBloc extends Bloc<NoticeEvent, NoticeState> {
  final NoticeRepository noticeRepository;

  NoticeBloc({required this.noticeRepository}) : super(NoticeInitial());

  @override
  Stream<NoticeState> mapEventToState(
    NoticeEvent event,
  ) async* {
    if (event is NoticeButtonPressed) {
      yield NoticeLoading();
      try {
        var res = await getFromSharedPreferences('response');
        var token = json.decode(res)['token'];
        if (token != '_') {
          var response = await noticeRepository.fetchNotice(
              token: token, studentId: event.studentId);
          print("printing the response in bloc");
          print(response);
          yield NoticeLoaded(content: response);
        }
      } catch (error) {
        print(error);
        if (error is SocketException) {
          yield NoticeLoadingFailure(error: {
            "exception_type": "SocketException",
            "message": "No Internet Connection!"
          });
        } else {
          yield NoticeLoadingFailure(error: {
            "exception_type": "GeneralException",
            "message": "An error occured. Please try again! $error"
          });
        }
      }
    }
  }
}
