import 'dart:async';
import 'dart:convert';
import 'dart:io';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/cupertino.dart';
import 'package:guardiansapp/helper_function.dart';
import 'package:guardiansapp/repositories/attendance_repository.dart';

part 'attendance_event.dart';
part 'attendance_state.dart';

class AttendanceBloc extends Bloc<AttendanceEvent, AttendanceState> {
  AttendanceRepository attendanceRepository = new AttendanceRepository();
  AttendanceBloc({required this.attendanceRepository})
      : super(AttendanceInitial());

  @override
  Stream<AttendanceState> mapEventToState(
    AttendanceEvent event,
  ) async* {
    if (event is AttendanceButtonPressed) {
      yield AttendanceLoading();
      try {
        var res = await getFromSharedPreferences('response');
        var token = json.decode(res)['token'];
        if (token != '_') {
          var response = await attendanceRepository.getAttendance(
              token: token,
              studentId: event.studentId,
              startDate: event.startDate,
              endDate: event.endDate);
          print("printing the response in bloc");
          print(response);
          yield AttendanceLoaded(content: response);
        }
      } catch (error) {
        print(error);
        if (error is SocketException) {
          yield AttendanceLoadingFailure(error: {
            "exception_type": "SocketException",
            "message": "No Internet Connection!"
          });
        } else {
          yield AttendanceLoadingFailure(error: {
            "exception_type": "GeneralException",
            "message": "An error occured. Please try again! $error"
          });
        }
      }
    }
  }
}
