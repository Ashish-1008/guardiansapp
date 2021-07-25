import 'package:bloc/bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:guardiansapp/blocs/login/login_bloc.dart';
import 'package:guardiansapp/blocs/master/master_bloc.dart';
import 'package:guardiansapp/repositories/authentication_repository.dart';
import 'package:guardiansapp/screens/app.dart';

class SimpleBlocObserver extends BlocObserver {
  @override
  void onEvent(Bloc bloc, Object? event) {
    print('onEvent $event');
    super.onEvent(bloc, event);
  }

  @override
  onTransition(Bloc bloc, Transition transition) {
    print('onTransition $transition');
    super.onTransition(bloc, transition);
  }

  @override
  void onError(BlocBase bloc, Object error, StackTrace stackTrace) {
    print('onError $error');
    super.onError(bloc, error, stackTrace);
  }
}

void main() {
  Bloc.observer = SimpleBlocObserver();
  final userRepo = new UserRepository();
  runApp(MultiBlocProvider(
    providers: [
      BlocProvider(
        create: (context) => MasterBloc()..add(Appstarted()),
      ),
      BlocProvider(
        create: (context) => LoginBloc(userRepository: userRepo),
      ),
    ],
    child: MyApp(
      userRepository: userRepo,
    ),
  ));
}
