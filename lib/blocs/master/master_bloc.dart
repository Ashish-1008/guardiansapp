import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:guardiansapp/helper_function.dart';

part 'master_event.dart';
part 'master_state.dart';

class MasterBloc extends Bloc<MasterEvent, MasterState> {
  MasterBloc() : super(MasterInitial());

  @override
  Stream<MasterState> mapEventToState(
    MasterEvent event,
  ) async* {
    // TODO: implement mapEventToState
    if (event is Appstarted) {
      yield MasterLoading();
      try {
        bool token;
        if (await getFromSharedPreferences('response') != '_') {
          token = true;
        } else {
          token = false;
        }
        yield MasterLoaded(loggedIn: token);
      } catch (error) {}
    }
  }
}
