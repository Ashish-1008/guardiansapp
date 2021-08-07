import 'dart:async';
import 'dart:convert';

import 'dart:io';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:guardiansapp/repositories/assignment_repo.dart';
import 'package:meta/meta.dart';

import '../../helper_function.dart';

part 'assignment_event.dart';
part 'assignment_state.dart';

class AssignmentBloc extends Bloc<AssignmentEvent, AssignmentState> {
  AssignmentRepository assignmentRepository;
  AssignmentBloc({required this.assignmentRepository})
      : super(AssignmentInitial());

  @override
  Stream<AssignmentState> mapEventToState(
    AssignmentEvent event,
  ) async* {
    if (event is AssignmentButtonPressed) {
      yield AssignmentLoading();
      try {
        var res = await getFromSharedPreferences('response');
        var token = json.decode(res)['token'];
        if (token != '_') {
          var response = await assignmentRepository.getAssignment(
              token: token, studentId: event.studentId);
          if (response['status'] == 0) {
            yield AssignmentLoadingFailure(error: {
              "exception_type": "SocketException",
              "message": response['message']
            });
          } else {
            yield AssignmentLoaded(content: response['data']);
          }
        }
      } catch (error) {
        if (error is SocketException) {
          yield AssignmentLoadingFailure(error: {
            "exception_type": "SocketException",
            "message": "No Internet Connection!"
          });
        } else {
          yield AssignmentLoadingFailure(error: {
            "exception_type": "GeneralException",
            "message": "An error occured. Please try again! $error"
          });
        }
      }
    }
  }
}
