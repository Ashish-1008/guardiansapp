import 'dart:async';
import 'dart:convert';
import 'dart:io';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:guardiansapp/repositories/notes_repository.dart';
import 'package:meta/meta.dart';

import '../../helper_function.dart';

part 'notes_event.dart';
part 'notes_state.dart';

class NotesBloc extends Bloc<NotesEvent, NotesState> {
  NotesRepository notesRepository;
  NotesBloc({required this.notesRepository}) : super(NotesInitial());

  @override
  Stream<NotesState> mapEventToState(
    NotesEvent event,
  ) async* {
    if (event is NotesButtonPressed) {
      yield NotesLoading();
      try {
        var res = await getFromSharedPreferences('response');
        var token = json.decode(res)['token'];
        if (token != '_') {
          var response = await notesRepository.getNotes(
              token: token, studentId: event.studentId);
          if (response['status'] == 0) {
            yield NotesLoadingFailure(error: {
              "exception_type": "SocketException",
              "message": response['message']
            });
          } else {
            yield NotesLoaded(content: response['data']);
          }
        }
      } catch (error) {
        if (error is SocketException) {
          yield NotesLoadingFailure(error: {
            "exception_type": "SocketException",
            "message": "No Internet Connection!"
          });
        } else {
          yield NotesLoadingFailure(error: {
            "exception_type": "GeneralException",
            "message": "An error occured. Please try again! $error"
          });
        }
      }
    }
  }
}
