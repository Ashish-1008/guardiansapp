import 'dart:async';
import 'dart:io';

import 'package:bloc/bloc.dart';
import 'package:guardiansapp/repositories/authentication_repository.dart';
import 'package:meta/meta.dart';

import '../../helper_function.dart';

part 'login_event.dart';
part 'login_state.dart';

class LoginBloc extends Bloc<LoginEvent, LoginState> {
  final UserRepository userRepository;

  LoginBloc({
    required this.userRepository,
  }) : super(LoginInitial());

  @override
  Stream<LoginState> mapEventToState(
    LoginEvent event,
  ) async* {
    if (event is LoginButtonPressed) {
      yield LoginLoading();
      try {
        final response = await userRepository.authenticate(
            phone: event.phone, password: event.password);
        //save to shared preference
        print(response);

        await saveToSharedPreferences('response', response);

        yield LoggedIn(token: response["token"], user: response['data']);
      } catch (error) {
        print('ssss');
        if (error is SocketException) {
          yield LoginFailure(error: {
            "exception_type": "SocketException",
            "message": "No Internet Connection!"
          });
        } else if (error is FormatException) {
          yield LoginFailure(error: {
            "exception_type": "AuthenticationException",
            "message": 'Invalid Username Password Combination!'
          });
        } else {
          yield LoginFailure(error: {
            "exception_type": "GeneralException",
            "message": 'An error occured! $error'
          });
        }
        // yield LoginFailure(error: error.toString());
      }
    }
    // if (event is LogoutButtonPressed) {
    //   try {
    //     var token = await getFromSharedPreferences('token');
    //     if (token != '_') {
    //       var response = await userRepository.logout(token: token);
    //       if (response['success'] == true) {
    //         await deleteFromSharedPreferences('token');
    //         Get.offAll(LoginPage());
    //       } else {
    //         yield LogoutFailure(error: {
    //           "exception_type": "AuthenticationException",
    //           "message": response['message']
    //         });
    //       }
    //     }
    //   } catch (error) {
    //     if (error is FormatException) {
    //       yield LogoutFailure(error: {
    //         "exception_type": "AuthenticationException",
    //         "message": "$error"
    //       });
    //     } else {
    //       yield LogoutFailure(error: {
    //         "exception_type": "GeneralException",
    //         "message": "An error occured while logging out!"
    //       });
    //     }
    //   }
    // }
  }
}
