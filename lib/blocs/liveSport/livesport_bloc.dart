import 'dart:async';
import 'dart:convert';
import 'dart:io';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:guardiansapp/repositories/liveSport_repository.dart';
import 'package:meta/meta.dart';

import '../../helper_function.dart';

part 'livesport_event.dart';
part 'livesport_state.dart';

class LiveSportBloc extends Bloc<LiveSportEvent, LiveSportState> {
  LiveSportRepository liveSportRepository;
  LiveSportBloc({required this.liveSportRepository})
      : super(LiveSportInitial());

  @override
  Stream<LiveSportState> mapEventToState(
    LiveSportEvent event,
  ) async* {
    if (event is LiveSportButtonPressed) {
      yield LiveSportLoading();
      try {
        var res = await getFromSharedPreferences('response');
        var token = json.decode(res)['token'];
        if (token != '_') {
          var response = await liveSportRepository.getLiveSport(token: token);
          if (response['status'] == 0) {
            yield LiveSportLoadingFailure(error: {
              "exception_type": "SocketException",
              "message": response['message']
            });
          } else {
            yield LiveSportLoaded(content: response['data']);
          }
        }
      } catch (error) {
        if (error is SocketException) {
          yield LiveSportLoadingFailure(error: {
            "exception_type": "SocketException",
            "message": "No Internet Connection!"
          });
        } else {
          yield LiveSportLoadingFailure(error: {
            "exception_type": "GeneralException",
            "message": "An error occured. Please try again! $error"
          });
        }
      }
    }
  }
}
