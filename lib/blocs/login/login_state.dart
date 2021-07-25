part of 'login_bloc.dart';

@immutable
abstract class LoginState {}

class LoginInitial extends LoginState {}

class LoginLoading extends LoginState {}

class LoginFailure extends LoginState {
  final error;

  LoginFailure({@required this.error});

  List<Object> get props => [error];

  @override
  String toString() => 'LoginFailure { error: $error }';
}

class LoggedIn extends LoginState {
  final String token;
  var user;

  LoggedIn({required this.token, this.user});

  List<Object> get props => [token, user];

  @override
  String toString() => 'LoggedIn { TOKEN: $token, USER :$user}';
}

class LoggedOut extends LoginState {}

class LogoutFailure extends LoginState {
  final error;

  LogoutFailure({@required this.error});

  List<Object> get props => [error];

  @override
  String toString() => 'LoginFailure { error: $error }';
}

class LogoutLoading extends LoginState {}
