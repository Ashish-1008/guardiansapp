import 'dart:async';
import 'dart:convert';
import 'dart:io';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:guardiansapp/repositories/library_repository.dart';

import '../../helper_function.dart';

part 'library_event.dart';
part 'library_state.dart';

class LibraryBloc extends Bloc<LibraryEvent, LibraryState> {
  LibraryBloc({required this.bookRepository}) : super(LibraryInitial());
  BookRepository bookRepository = new BookRepository();

  @override
  Stream<LibraryState> mapEventToState(
    LibraryEvent event,
  ) async* {
    if (event is LibraryButtonPressed) {
      yield LibraryLoading();
      try {
        var res = await getFromSharedPreferences('response');
        var token = json.decode(res)['token'];
        if (token != '_') {
          var response = await bookRepository.getBooks(
              token: token,
              studentId: event.studentId,
              dataType: event.dataType);

          yield LibraryLoaded(content: response);
        }
      } catch (error) {
        print(error);
        if (error is SocketException) {
          yield LibraryLoadingFailure(error: {
            "exception_type": "SocketException",
            "message": "No Internet Connection!"
          });
        } else {
          yield LibraryLoadingFailure(error: {
            "exception_type": "GeneralException",
            "message": "An error occured. Please try again! $error"
          });
        }
      }
    }
  }
}
